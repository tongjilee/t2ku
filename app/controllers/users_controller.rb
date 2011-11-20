# -*- encoding : utf-8 -*-
class UsersController < InheritedResources::Base
  before_filter :authenticate_user!,:except=>[:show,:create]
  def update
    update! do |success, failure|
      failure.html { render :file=>'devise/registrations/edit' }
      success.html { redirect_to edit_user_registration_path }
    end
  end
  
  def create
    u = User.new
    u.name = params[:name]
    u.email = params[:email]
    u.password = params[:password]
    u.password_confirmation = params[:password_confirmation]
    if u.save
      render json:{no_validation:true,ok:true}
    else
      render json:{no_validation:true,ok:false,what:u.errors.full_messages.first}
    end
  end
  
end
