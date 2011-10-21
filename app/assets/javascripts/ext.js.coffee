# This file make extensions to the existing libraries
jQuery.fn.exists = -> jQuery(this).length>0
jQuery.fn.textCompact = ->
  this.text().trim() #TODO: rip off extra spaces

class AssertException
  constructor:(@message,@line)->
    
  what:->
    this.message;

  
window.assert = (exp, message, line)->
  throw new AssertException(message, line) unless exp
  
window.locale = $('html').attr('lang')
window.locale = 'en' if !window.locale
window.I18n = 
  t: (token) ->
    v = eval("this.data['"+locale+"']."+token)
    if v?
      return v
    else
      return 'Unknown'
  data:
    'en':
      t2ku:
        hold_on: "Processing"
        loginreg:
          button11: "Login"
          button12: "Cancel"
          button13: "Page"
          button21: "Signup"
          button22: "Cancel"
          button23: "Page"
          badlength:(what,min,max) -> what+" should be a finite sequence of $n$ characters where $"+min+"\\le n\\le "+max+"$."
          emailformat: "E-mail should be like username@server.com."
          passwords_mismatch: "$P_1\\neq P_2$, where $P_1$ and $P_2$ are your Password and Password Confirmation, respectively."
    'zh-CN':
      t2ku:
        hold_on: "处理中"
        loginreg:
          button11: "登录"
          button12: "取消"
          button13: "转登录页"
          button21: "注册"
          button22: "取消"
          button23: "转注册页"
          badlength:(what,min,max) -> what+" 应是一个由 $n$ 个字符组成的有限序列，其中 $"+min+"\\le n\\le "+max+"$."
          emailformat: "E-mail格式不对，应如ui@jquery.com"
          passwords_mismatch: "密码不符"

window.tt = (token) ->
  I18n.t('t2ku.'+token)

jQuery ->
  $('form').each(->
  	$(this).submit(->
  		$('input:submit',this).attr("disabled","disabled")
  		$('input:submit',this).val(tt('hold_on'))
  		return true
  	)
  )
  $('.tiptipsy').tipsy({gravity: $.fn.tipsy.autoNS,fade: true});