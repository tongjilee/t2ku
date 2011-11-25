# -*- encoding : utf-8 -*-
require 'gollum'
class Item < ActiveRecord::Base
  has_many :children, :class_name => "Item"
  belongs_to :father, :class_name => "Item", :foreign_key=>'item_id'
  belongs_to :book
  belongs_to :itemizable, :polymorphic => true

  extend FriendlyId
  friendly_id :name, :use => :slugged
  scope :pageitems,where(itemizable_id:nil)
  scope :topitems,where('item_id IS NULL')
  scope :rank,order('rank')
  attr_reader :page
  after_initialize Proc.new{
    if self.book and self.name and !self.itemizable
      @page = self.book.wiki.page(self.name)
    end
  }
  def brothers
    self.book.items.where(item_id:self.item_id)
  end
  
  def next
    ret = self.brothers.where('rank>?',self.rank).rank.first
    ret = self.children.rank.first if !ret and self.children
    ret
  end

  def prev
    ret = self.brothers.where('rank<?',self.rank).order('rank desc').first
    ret = self.father.brothers.where('rank<?',self.rank).order('rank desc').first if !ret and self.father
    ret
  end

end
