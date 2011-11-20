# -*- encoding : utf-8 -*-
class ChannnnnUsers < ActiveRecord::Migration
  def up
    add_column :users,:name,:string
    add_column :users,:website,:string
    add_column :users,:location,:string
    add_column :users, :signature,:text
  end

  def down
  end
end
