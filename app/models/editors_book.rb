class EditorsBook < ActiveRecord::Base
  belongs_to :editor,:class_name=>'User'
  belongs_to :book
end