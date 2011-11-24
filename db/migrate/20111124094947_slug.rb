class Slug < ActiveRecord::Migration
  def up
    add_column :items, :slug, :string
    
    add_index :items, :slug, :unique => true
  end
  
  def down
  end
end


