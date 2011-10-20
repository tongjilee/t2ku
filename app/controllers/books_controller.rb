class BooksController < InheritedResources::Base
  def show
    show! do |format|
      format.html{render layout:'bookview'}
    end
  end
end