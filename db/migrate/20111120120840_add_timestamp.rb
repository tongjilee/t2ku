# -*- encoding : utf-8 -*-
class AddTimestamp < ActiveRecord::Migration
  def change
    add_column :authors,:created_at,:datetime
    add_column :authors_books,:created_at,:datetime
    add_column :books,:created_at,:datetime
    add_column :definitions,:created_at,:datetime
    add_column :problems,:created_at,:datetime
    add_column :tasks,:created_at,:datetime
    add_column :theorems,:created_at,:datetime
    
    add_column :authors,:updated_at,:datetime
    add_column :authors_books,:updated_at,:datetime
    add_column :books,:updated_at,:datetime
    add_column :definitions,:updated_at,:datetime
    add_column :problems,:updated_at,:datetime
    add_column :tasks,:updated_at,:datetime
    add_column :theorems,:updated_at,:datetime
  end
end
