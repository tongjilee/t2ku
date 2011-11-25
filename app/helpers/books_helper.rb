# -*- encoding : utf-8 -*-
module BooksHelper
  def traverse_children(item)
    unless item.children.blank?
      ret = '<ul>'
      item.children.each do |child|
        ret += "<li>#{link_to(child.name,book_item_path(child.book,child))}</li>\n"
        ret += traverse_children(child)
      end
      ret += '</ul>'
    else
      ''
    end
  end
end
