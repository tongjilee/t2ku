class T2Ku.Views.MissionLaunch extends Backbone.View
  events:
    "click #p_1":"p_1_clicked"
    "click #p_2":"p_2_clicked"
    
  constructor:(options)->
    super(options)
    # @options.model = window.active_Task
#    @options.model.bind('error',this.render_error)
#    @options.model.bind('success',this.render_success)

  p_1_clicked:(e)->
    if $('#p_2').is('.selected')
      $('#portal_main_2').hide('slide',{direction:'up'},300,->
        $('#portal_main_1').show('slide',{direction:'down'})
      )
      $('#nav-highlight-vertical').animate('margin-top': '-=60', 200)
      $('#p_1').addClass('selected');
      $('#p_2').removeClass('selected')
      
  p_2_clicked:(e)->
    if $('#p_1').is('.selected')
      $('#portal_main_1').hide('slide',{direction:'up'},300,->
        $('#portal_main_2').show('slide',{direction:'down'})
      )
      $('#nav-highlight-vertical').animate('margin-top': '+=60', 200)
      $('#p_2').addClass('selected')
      $('#p_1').removeClass('selected')
