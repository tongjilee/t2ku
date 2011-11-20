class Book < ActiveRecord::Base
  has_and_belongs_to_many :authors


def definitions;[];end
def theorems;[];end
def problems;[];end
  # has_many :items
  # has_many :definitions,:through=>:book_items
  # has_many :theorems,:through=>:book_items
  # has_many :problems,:through=>:book_items
  def authors_input
    authors.collect(&:name).join(', ')
  end
  def authors_input=(arg)
    arr = arg.split(',').collect{|x| x.strip}.compact
    arr.delete_if{|x| ''==x}
    self.authors = []
    arr.each do |name|
      self.authors << self.authors.build(name:name)
    end
  end
end