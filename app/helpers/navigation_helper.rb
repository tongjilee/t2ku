module NavigationHelper
  
  def navigation_array
    retarr = []
    
    is_editing = ('edit'==controller.action_name||'update'==controller.action_name)
    is_creating = ('new'==controller.action_name||'create'==controller.action_name)
    is_showing = ('show'==controller.action_name)
    is_listing = ('index'==controller.action_name)
    
    case controller.controller_name
      when 'tasks'
        retarr << lize(link_to('Tasks on Queue',tasks_path))
      when 'books'
        retarr << lize(link_to('All Books',books_path),is_listing)
        if is_showing
          retarr << lize(link_to(@book.title,@book),is_showing)
        else
          retarr << lize(link_to('New Book',new_book_path),is_creating)
        end
      when 'compilations'
        retarr << lize(link_to('All Compilations',compilations_path),is_listing)
        if is_showing
          retarr << lize(link_to(@compilation.title,@compilation),is_showing)
        else
          retarr << lize(link_to('New Compilations',new_compilation_path),is_creating)
        end
      when 'definitions'
        retarr << lize(link_to('Definitions',definitions_path))
      when 'theorems'
        retarr << lize(link_to('Theorems',theorems_path))
      when 'problems'
        retarr << lize(link_to('Problems',problems_path))
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
      when 'books'
        retarr << lize(link_to('Books',books_path))
    end
    retarr
  end
  
end