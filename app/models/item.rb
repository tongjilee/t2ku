# -*- encoding : utf-8 -*-
require 'gollum'
class Item < ActiveRecord::Base
  has_many :children, :class_name => "Item"
  belongs_to :father, :class_name => "Item"
  belongs_to :book
  belongs_to :itemizable, :polymorphic => true

  extend FriendlyId
  friendly_id :name, :use => :slugged
  scope :pageitems,where(itemizable_id:nil)
  scope :topitems,where('item_id IS NULL')
  attr_reader :page
  after_initialize Proc.new{
    if self.book and self.name and !self.itemizable
      @page = self.book.wiki.page(self.name)
    end
  }
end
