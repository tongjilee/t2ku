# -*- encoding : utf-8 -*-
class Problem < ActiveRecord::Base
  belongs_to :book
  has_many :items,:as=>:itemizable
end
