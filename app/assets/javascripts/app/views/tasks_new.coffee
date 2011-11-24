class T2Ku.Views.TasksNew extends Backbone.View
  events:
    "click #preview_button":"parse"
    "click #qiuzheng_button":"prove"
    "click #h2_11":"h2_11_clicked"
    
  constructor:(options)->
    super(options)
    window.active_Task = new T2Ku.Models.Task
    window.myCodeMirror = CodeMirror.fromTextArea($('#text_desc_textarea')[0],
      lineNumbers: false
      theme: "t2math"
      mode: "text/x-t2math"
      tabMode: "shift"
      indentUnit: 4
      # onChange: (ins)->
      #   ins.operation(->
      #     $('.cm-math').each((index, Element)->
      #       MathJax.Hub.Queue(["Typeset",MathJax.Hub, Element])
      #     )
      #   )
      onFocus: (ins)->
        ins.setValue(ins.getValue())
        
      # onKeyEvent: (instance, e) ->
      #   # cur = instance.getCursor(false)
      #   # token = instance.getTokenAt(cur)
      #   # tprop = token
      #   false
    )
    @options.model = window.active_Task
#    @options.model.bind('error',this.render_error)
#    @options.model.bind('success',this.render_success)

  parse:(e)->
    e.preventDefault()
    e.stopPropagation()
    $('#parse_result').hide()
    $('#parse_suc').hide();
    window.active_Task.set({description:window.myCodeMirror.getValue()})
    window.myCodeMirror.setSelection({line:0,ch:0},{line:0,ch:0})
    $('.CodeMirror-lines pre').not('.CodeMirror-cursor').each((index, Element)->
      str = $(this).html()
      ret = ''
      gotmath = false
      $.each(str.split('<span class="cm-dollar">'),(index, value)->
        if gotmath and '$</span>'==value.substr(0,8)
          value = value.substr(8);
          gotmath = false
        if 0==index%2
          ret += value
        else
          gotmath = true
          ret += '<span class="cm-math">'+$('<span>'+value).text()+'$</span>'
      )
      $(this).html(ret)
    )
    $('span.cm-math').each((index,Element)->
      MathJax.Hub.Queue(["Typeset", MathJax.Hub, this]); 
    )
    MathJax.Hub.Queue(->
      window.active_Task.startOver()
      to_rectify = ''
      code = []
      $('.CodeMirror-lines pre').not('.CodeMirror-cursor').each((index, Element)->
        for kid in $(Element).children()
          code.push({i:index,kid})
      )
      msg = ''
      try
        window.active_Task.parseFrom(code)
      catch exception
        if exception.line
          msg = 'Line '+exception.line+': '+exception.what()
        else
          msg = exception.what()
        to_rectify = '<li>'+msg+'</li>'
        if exception.line
          pre = $('.CodeMirror-lines pre').not('.CodeMirror-cursor')[exception.line-1]
          $(pre).addClass('syntaxErrorLine')
        $("#please_rectify").html(to_rectify);
        $("#parse_result").show('slide',{direction:'up'},'fast');

      $('#parse_suc').show('slide',{direction:'up'},'fast') unless msg;
    )
    
  prove:(e)->
    window.active_Task.set({description:window.myCodeMirror.getValue()})
    if T2Ku.current_user
      $('#new_task').submit()
    else
      $('#login_link').trigger('click')

  h2_11_clicked:(e)->
    $('#portal_help').toggle('slide',{ direction:'up' },'fast');
    $('#portal_arrow_down').toggle();
    $('#portal_arrow_up').toggle();