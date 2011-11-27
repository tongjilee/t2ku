# -*- encoding : utf-8 -*-
module NavigationHelper

  def navigation_array
    retarr = []

    is_editing = ('edit'==controller.action_name||'update'==controller.action_name)
    is_creating = ('new'==controller.action_name||'create'==controller.action_name)
    is_showing = ('show'==controller.action_name)
    is_listing = ('index'==controller.action_name)

    # basic RESTful submenus is done via this lize_many lambda
    lize_many = ->(controller_name){
      small = controller_name.singularize
      big = small.camelize
      eval <<-CODE
        retarr << lize(link_to('All #{controller_name.camelize}',#{controller_name}_path),is_listing)
        if is_showing
          retarr << lize(link_to(@#{small}.title,@#{small}),is_showing)
        else
          retarr << lize(link_to('New #{small.camelize}',new_#{small}_path),is_creating)
        end
      CODE
    }
    case controller.controller_name
    when 'tasks'
      retarr << lize(link_to('Tasks on Queue',tasks_path),is_listing)
    when 'items'
      retarr << lize(link_to('Books',books_path))
      retarr << lize(link_to(@book.title,@book))
      retarr << lize(link_to(@item.name,book_item_path(@book,@item)),true)
    when 'books','robots'
      lize_many.(controller.controller_name)
    when 'definitions','theorems','problems'
      retarr << lize(link_to('Definitions', definitions_path), controller.controller_name=='definitions')
      retarr << lize(link_to('Theorems', theorems_path), controller.controller_name=='theorems')
      retarr << lize(link_to('Problems', problems_path), controller.controller_name=='problems')
    when 'users'
      if is_showing
        retarr << lize(link_to(@user.name,@user),is_showing)
      end
    when 'account','registrations'
      retarr << lize(link_to('My Dashboard',account_path),controller.action_name=='index')
      retarr << lize(link_to('Edit Profile', edit_user_registration_path), controller.controller_name=='registrations' && is_editing)
    when 'home'
      retarr << lize(link_to('Downloads',downloads_path),controller.action_name=='downloads')
      retarr << lize(link_to('About',about_path),controller.action_name=='about')
    end
    retarr
  end
  
  
end
