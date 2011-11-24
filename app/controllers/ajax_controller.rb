class AjaxController < ApplicationController
  def save_new_task_description
    session[:new_task_description] = params[:new_task_description]
    render json:{content_saved:true}
  end
end