# -*- encoding : utf-8 -*-
class Definition<ActiveRecord::Base
  belongs_to :book
  has_many :items,:as=>:itemizable
end
