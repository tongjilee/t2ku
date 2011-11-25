# -*- encoding : utf-8 -*-
require 'gollum'
require 'nokogiri'
class Book < ActiveRecord::Base
  validates_presence_of :title
  validates_uniqueness_of :title
  
  def wiki_path
    if self.id
      File.expand_path("books/#{self.id}.git/",Rails.root)
    else
      nil
    end
  end
  attr_reader :wiki
  after_initialize Proc.new{
    @wiki = Gollum::Wiki.new(self.wiki_path, {}) if self.wiki_path
  }
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :users
  before_destroy Proc.new{
    self.authors.delete_all
    self.users.delete_all
  }
  has_many :items
  # has_many :definitions,:through=>:book_items
  # has_many :theorems,:through=>:book_items
  # has_many :problems,:through=>:book_items
    
def definitions;[];end
def theorems;[];end
def problems;[];end

  def authors_input
    authors.collect(&:name).join(', ')
  end
  def authors_input=(arg)
    arr = arg.split(',').collect{|x| x.strip}.compact
    arr.delete_if{|x| ''==x}
    @authors_input = arr
  end
  before_save Proc.new{
    if @authors_input
      self.authors.delete_all
      @authors_input.each do |name|
        self.authors << self.authors.build(name:name)
      end
    end
  }
  def touch_user(user)
    unless self.users.exists?(id:user.id)
      self.users << user
    end
  end
  extend FriendlyId
  friendly_id :title, :use => :slugged
  
  def create_book_git!
     if self.wiki_path
      if(!File.exists?(self.wiki_path))
        # now create the git repository for the book
        p cmd="cd #{Rails.root}/books;git init;mv .git #{self.id}.git"
        p `#{cmd}`
      end
    end
  end
  after_create :create_book_git!
  def firstpage
    self.items.pageitems.topitems.rank.first
  end
end
