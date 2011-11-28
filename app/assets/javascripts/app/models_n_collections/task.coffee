class T2Ku.Models.Task extends Backbone.Model
  urlRoot:'/tasks'
  constructor:(options)->
    super(options)
    console.log('Task model instantiated with id='+this.get('id'))
    this.startOver()
    this.bind("change:description",->
      $.post('/ajax/save_new_task_description',{new_task_description:this.get('description')})
    )
    
  already_declared:(math)->
    @vertices[math]!=null
    
  declare:(math,klass)-> #Let `math` be `klass`
    @vertices[math] = klass
    
  father_son:(mathmaster,math)-> #Let `math` be ... of `mathmaster`
    @edges[math] = mathmaster
  
  startOver:->
    @vertices = {}
    @edges = {} #father is whom?
    @premises = []
    @conclusions = []
    
  objects2html:->
    JSON.stringify(@vertices)+'<br>'+JSON.stringify(@edges)

  parseFrom:(code)->
    assert(code.length>0,'No information provided.')
    #code = [<span>,<span>,...,<span>]
    verb = ''
    i = j = kid = last_kid = 0
    reset_loop_vars = ->
      i = code[j].i #original line number, for error messages
      last_kid = kid
      kid = code[j].kid #current span
    move_forward = ->
      j++
      if j<code.length
        reset_loop_vars()
      else
        #we need more info, but there is none
        assert(false,'Expecting more lines')
    current_math = ->
      $('script',kid).textCompact()
    sentenceMissionAccomplished = ->
      #This sentence is over!
      if $(kid).hasClass('cm-comma_of_sentence')
        return true
      else if $(kid).hasClass('cm-end_of_sentence')
        verb = ''
        return true
      else
        return false
    bssert = (exp, message)->
      assert(exp,message,(i+1))
    while j<code.length
      reset_loop_vars()
      if ''==verb
        bssert($(kid).hasClass('cm-verb'),'expecting a verb')
        verb = $(kid).textCompact()
        move_forward()
      switch verb
        when 'Let'
          bssert($(kid).hasClass('cm-math'),'expecting a math expression after `Let`')
          math = current_math()
          move_forward()
          bssert($(kid).hasClass('cm-verb') and 'be'==$(kid).textCompact(),'expecting a `be` after `Let...`')
          move_forward()
          bssert($(kid).hasClass('cm-complement'),'expecting more info after `Let...be`')
          signature = $(kid).textCompact()
          window.active_Task.declare(math,signature)
          move_forward()
          if sentenceMissionAccomplished()# without `of`
            j++
            continue
          else# with of
            bssert($(kid).hasClass('cm-keyword') and 'of'==$(kid).textCompact(),'Expecting `of` after`'+$(last_kid).textCompact()+'`')
            move_forward()
            bssert($(kid).hasClass('cm-math'),'Expecting a math expression after `of`')
            mathmaster = current_math()
            bssert(window.active_Task.already_declared(mathmaster),'Undefined math object `'+mathmaster+'`')
            window.active_Task.father_son(mathmaster,math)
            move_forward()
            # it must be over now
            if sentenceMissionAccomplished()
              j++
              continue
            else
              bssert(false,'The sentence should be over now after `'+$(last_kid).textCompact()+'`')
        when 'Suppose that'
          # bssert($(kid).hasClass('cm-math'),'expecting a math expression after `Suppose that`')
          # math = current_math()
          # move_forward()
          # if $(kid).hasClass('cm-keyword')
          #   switch $(kid).textCompact()
          #     when 'for all'
          #  <<TODO>>     
          j++
        else
          bssert(false,'has a unrecognized verb `'+verb+'`')
  
    
class T2Ku.Collections.Tasks extends Backbone.Collection
  model: T2Ku.Models.Task
  url: '/tasks'