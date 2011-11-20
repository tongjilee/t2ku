# -*- encoding : utf-8 -*-
class PagesController < InheritedResources::Base
  belongs_to :book
  layout 'bookview'
  def index
    index!
    binding.pry
  end
  def show
    show!
    binding.pry
    # def show_page_or_file
    #   @book = Book.find(params[:id])
    #   wiki = @book.wiki
    #   name = params[:name]
    #   if page = wiki.page(name)
    #     @page = page
    #     @name = name
    #     @content = page.formatted_data
    #     @editable = true
    #     render :action=>:page
    #   elsif file = wiki.file(name)
    #     send_data file.raw_data, type:file.mime_type
    #   else
    #     @name = name
    #     render :action=>:create
    #   end
    # end
  end
end