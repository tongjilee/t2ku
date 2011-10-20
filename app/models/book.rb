class Book < ActiveRecord::Base
  belongs_to :user
  has_many :definitions
  has_many :theorems
  has_many :problems
end