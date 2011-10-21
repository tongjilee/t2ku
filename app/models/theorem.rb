class Theorem < ActiveRecord::Base
  belongs_to :book
  belongs_to :compilation
end