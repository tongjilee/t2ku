class T2Ku.Views.QueryNew extends Backbone.View
  events:
    "click #query_wrapper":"query_wrapper_click"
    "click #keyboard_show":"keyboard_click"
    "click #keyboard_new":"keyboard_click"
    "click #keyboard_edit":"keyboard_click"
    "click #keyboard_search":"keyboard_click"
    "click #keyboard_definition":"keyboard_click"
    "click #keyboard_theorem":"keyboard_click"
    "click #keyboard_problem":"keyboard_click"
    "click #keyboard_mission":"keyboard_click"
    "click #keyboard_of":"keyboard_click"
    "click #keyboard_no":"keyboard_click"
    "click #keyboard_about":"keyboard_click"
    "click #keyboard_proof":"keyboard_click"
    "click #keyboard_symbol":"keyboard_click"
    "click #keyboard_constructor":"keyboard_click"
    "click #keyboard_adjective":"keyboard_click"
    "click #keyboard_predicate":"keyboard_click"
    "click #keyboard_c":"keyboard_click"
    "click #keyboard_pm":"keyboard_click"
    "click #keyboard_div":"keyboard_click"
    "click #keyboard_times":"keyboard_click"
    "click #keyboard_7":"keyboard_click"
    "click #keyboard_8":"keyboard_click"
    "click #keyboard_9":"keyboard_click"
    "click #keyboard_minus":"keyboard_click"
    "click #keyboard_4":"keyboard_click"
    "click #keyboard_5":"keyboard_click"
    "click #keyboard_6":"keyboard_click"
    "click #keyboard_plus":"keyboard_click"
    "click #keyboard_1":"keyboard_click"
    "click #keyboard_2":"keyboard_click"
    "click #keyboard_3":"keyboard_click"
    "click #keyboard_0":"keyboard_click"
    "click #keyboard_point":"keyboard_click"
    "click #keyboard_go":"keyboard_click"

  constructor:(options)->
    super(options)
  # @options.model = window.active_Task
  #    @options.model.bind('error',this.render_error)
  #    @options.model.bind('success',this.render_success)

  keyboard_click:(e)->
    whichKey = e.target.id.split('_')[1]
    target = $('#query_field')
    nowValue = $('#query_field').val()
    switch whichKey
      when 'c'
        target.val('')
      when 'go'
        alert('easy to go')
      when 'pm'
        if nowValue.match(/^\-/)
          target.val(nowValue.substr(1,nowValue.length-1))
        else
          target.val('-'+nowValue)

      else
        seperator = if nowValue.match(/\s$/) then '' else ' '
        seperator = '' if whichKey.match(/^\d+$/)
        target.val(nowValue+seperator+whichKey)
    $('#query_field').focus()
  query_wrapper_click:(e)->
    $('#query_field').focus()