# -*- encoding : utf-8 -*-
class ChannnnnTasks < ActiveRecord::Migration
  def up
    add_column :tasks,:description,:text
  end

  def down
  end
end
