class T2Ku.Views.UsersNew extends Backbone.View
  events:
    "submit form":"createUser"

  render_error:(jqXHR, textStatus, errorThrown)=>
    if textStatus.status
      this.updateTips('The server returns a '+textStatus.status+' response.')
    else
      this.updateTips(textStatus)  

  constructor:(options)->
    super(options)
    @options.model = new T2Ku.Models.User
    @options.model.bind('error',this.render_error)
    @options.model.bind('success',this.render_success)
        
  createUser:(e)->
    e.preventDefault()
    e.stopPropagation()
    $('#error_reg').hide()
    @options.model.unset("error")
    params={
      name: e.target["user[name]"].value
      email: e.target["user[email]"].value
      password: e.target["user[password]"].value
      password_confirmation: e.target["user[password_confirmation]"].value
    }
    @options.model.save(params,
      beforeSend:(jqXHR, settings)=>
        $('button.ui-button').attr('disabled','disabled')
        $('#spinningWheel_reg').show()
        $('#reg-form').height($('#spinningWheel_reg').height()+230)
      complete:(jqXHR, textStatus)=>
        $('button.ui-button').removeAttr('disabled')
        $('#spinningWheel_reg').hide()
      success:(jqXHR, textStatus, errorThrown)=>
        if textStatus.ok
          $('#reg_normal_stuff').hide()
          $('#reg_display_when_success').show()
        else
          this.updateTips(textStatus.what)
    )
    
  updateTips:(t)->
    $('#error_reg').show()
    $('#error_reg_content').text(t)
    $('#reg-form').height($('#error_reg').height()+230)
    MathJax.Hub.Queue(["Typeset",MathJax.Hub,$('#error_reg_content')[0]])