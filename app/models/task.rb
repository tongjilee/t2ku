# -*- encoding : utf-8 -*-
class Task < ActiveRecord::Base
  belongs_to :user
end
