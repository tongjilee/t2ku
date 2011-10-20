class Book < ActiveRecord::Base
  belongs_to :user
  has_many :definitions
  has_many :theorems
  has_many :problems
  has_many :editors_books
  has_many :editors,:through=>:editors_books,:class_name=>'User'
  has_many :authors_books
  has_many :authors,:through=>:authors_books
end