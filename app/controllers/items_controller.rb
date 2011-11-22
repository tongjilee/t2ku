# -*- encoding : utf-8 -*-
class ItemsController < InheritedResources::Base
  belongs_to :book
  layout 'bookview'
  def show
    @book = Book.find(params[:book_id])
    @item = @book.items.find_by_name(params[:id])
    # show!
  end
end