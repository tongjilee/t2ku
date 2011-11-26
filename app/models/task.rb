# -*- encoding : utf-8 -*-
class Task < ActiveRecord::Base
  belongs_to :user
  def self.to_canonical(description)
    description=description.split(/\s+/).join(' ')
    ret = ''
    description.split('.').each do |sentence|
      ret+=sentence.split(',').collect{|sub|
        sub.strip
      }.join(',')
    end
    ret
  end
end
