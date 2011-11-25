# -*- encoding : utf-8 -*-

module ApplicationHelper

  def err(resource)
    alert_or_notice(resource.errors.full_messages.join(",#{tt('and')}"),nil,{go_away:false}) if resource and !resource.errors.empty?
  end
  def avatar_url(user,s=80)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?r=PG&s=#{s}"
  end

  def lize(str,condition=false)
    if condition
      "<li class=\"active\">#{str}</li>"
    else
      "<li>#{str}</li>"
    end
  end
  
  def clear
    '<br style="clear:both">'.html_safe
  end
  
  def clearer
    '<br style="clear:both">'.html_safe
  end


  def get_title
    ret = 'T2Ku'
    trans = I18n.t("t2ku.navigation_tab.#{params[:controller]}_#{params[:action]}",default:'not-found')
    trans = I18n.t("t2ku.navigation_tab.#{params[:controller]}",default:'not-found') if 'not-found'==trans
    ret += ' - '+trans unless 'not-found'==trans
    ret
  end
  def mathjax_config
    '<script type="text/x-mathjax-config">
  	    MathJax.Hub.Config({
  	     tex2jax: {
  	       inlineMath: [ ["$","$"] ],
  	       processEscapes: true
  	     }
  	    });
  	</script>'.html_safe
  end
  
  def language_switch
    cl='special'
    if I18n.locale.to_s=='en'
      link_to '中文',request.env['REQUEST_PATH']+'?locale=zh-CN',:class => cl
    else
      link_to 'English',request.env['REQUEST_PATH']+'?locale=en',:class => cl
    end
  end
  
  def tt(path)
    I18n.t('t2ku.'+path)
  end
  
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  
  def pos_signature
    "#{params[:controller].parameterize}_#{params[:action].parameterize}"
  end
  
  def navigation_tab_root
    text = I18n.t("t2ku.navigation_tab_root")
    if "#{params[:controller].parameterize}_#{params[:action].parameterize}"=="tasks_new"
      "<span class=\"selected\">#{text}</span>".html_safe
    else
      link_to text,'/'
    end
  end
  
  def navigation_tab(controller=nil)
    current = true if controller.to_s == params[:controller]
    current = false if "#{params[:controller].parameterize}_#{params[:action].parameterize}"=="tasks_new"
    text = I18n.t("t2ku.navigation_tab.#{controller}")
    text = current_user.name if :account==controller and current_user
    if current
      "<span class=\"selected\">#{text}</span>".html_safe
    else
      link_to text,"/#{controller}"
    end
  end
  
  
  def alert_or_notice(alert = nil,notice = nil,options = {})
    ret = ''
    options[:style] ||= ''
    if alert or notice
      if notice
        notice+='.' unless notice.ends_with?('.')
        simple = (notice==t('devise.sessions.signed_in') || notice==t('devise.sessions.signed_out'))
        if simple
          ret <<'<div class="alert_or_notice" style="'+options[:style]+'">
        			<div class="ui-widget anotice"  id="notice">
        				<div style="padding: 0pt 0.7em;" class="ui-state-highlight ui-corner-all"> 
        					<p><span style="float: left; margin-right: 0.3em;" class="ui-icon ui-icon-info"></span>
        					<strong>'+tt('notice')+'</strong>: '+notice+'</p>
        				</div>
        			</div>
        			</div>
        			<script type="text/javascript" charset="utf-8">
                $(function() {
        	        setTimeout(function() {$(".alert_or_notice").hide(\'slide\',{direction:\'up\'},\'slow\')}, 2000 );
                });
              </script>'
        else
          ret <<'<div class="alert_or_notice" style="'+options[:style]+'">
    			<div class="ui-widget anotice"  id="notice">
    				<div style="padding: 0pt 0.7em;" class="ui-state-highlight ui-corner-all"> 
    					<p><span style="float: left; margin-right: 0.3em;" class="ui-icon ui-icon-info"></span>
    					<strong style="line-height:18px">'+tt('notice')+'</strong>: </p><p style="padding-left:20px">'+notice+'</p>
    					<p style="text-align:right;padding-right:8px"><strong><a href="#" onclick="$(this).parent().parent().parent().parent().parent().hide(\'slide\',{direction:\'up\'},\'slow\')" class="special underline">Done</a></strong></p>
    				</div>
    			</div>
    			</div>'
		    end
      end
      if alert
        alert+='.' unless alert.ends_with?('.')
        ret <<'<div class="alert_or_notice" style="'+options[:style]+'">
  			<div class="ui-widget afailure" id="alert">
  				<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;"> 
  					<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span> 
  					<strong>'+tt('failed')+':</strong> '+alert+'</p>
  				</div>
  			</div>
  			</div>'
      end
    end
    ret.html_safe
  end
  
  def under_development(height)
    return image_tag('under_construction.png',:style=>"height:#{height}px").html_safe
  end
end
