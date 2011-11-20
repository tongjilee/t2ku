# -*- encoding : utf-8 -*-
class Page < ActiveRecord::Base
  def initialize(page)
    @gpage = page
  end
  def method_missing(method_id, *args, &block)
    binding.pry
    @page.send(method,args) # todo:args
  end
  include ActiveModel::Validations
  def name
    'name'
  end
end