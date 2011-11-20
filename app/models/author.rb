# -*- encoding : utf-8 -*-
class Author < ActiveRecord::Base
  has_and_belongs_to_many :books
  before_destroy Proc.new{
    self.books.delete_all
  }
  extend FriendlyId
  friendly_id :name, :use => :slugged
end
