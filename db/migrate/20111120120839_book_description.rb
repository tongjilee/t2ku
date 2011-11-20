# -*- encoding : utf-8 -*-
class BookDescription < ActiveRecord::Migration
  def up
    add_column :books,:description,:text
  end
end
