class UsersController < InheritedResources::Base
  before_filter :authenticate_user!,:except=>[:show]
  def update
    update! do |success, failure|
      failure.html { render :file=>'devise/registrations/edit' }
      success.html { redirect_to edit_user_registration_path }
    end
  end
end
