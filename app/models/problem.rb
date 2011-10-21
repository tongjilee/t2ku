class Problem < ActiveRecord::Base
  belongs_to :book
  belongs_to :compilation
end