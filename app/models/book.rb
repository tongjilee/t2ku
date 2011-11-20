class Book < ActiveRecord::Base
  has_and_belongs_to_many :authors
  # has_many :items
  # has_many :definitions,:through=>:book_items
  # has_many :theorems,:through=>:book_items
  # has_many :problems,:through=>:book_items
end