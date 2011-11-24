# -*- encoding : utf-8 -*-
class ItemsController < InheritedResources::Base
  belongs_to :book
  layout 'bookview'
end
