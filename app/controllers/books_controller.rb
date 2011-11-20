# -*- encoding : utf-8 -*-
class BooksController < InheritedResources::Base
  before_filter :authenticate_user!,:except=>[:show,:index]
  def show
    show! do |format|
      format.html{render layout:'bookview'}
    end
  end
end
