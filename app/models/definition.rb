# -*- encoding : utf-8 -*-
class Definition<ActiveRecord::Base
  has_many :items,:as=>:itemizable
end
