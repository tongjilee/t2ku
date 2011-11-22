# -*- encoding : utf-8 -*-
require 'gollum'
class Item < ActiveRecord::Base
  belongs_to :book
  attr_reader :page
  after_initialize Proc.new{
    if self.book and self.name
      @page = self.book.wiki.page(self.name)
    end
  }
end
