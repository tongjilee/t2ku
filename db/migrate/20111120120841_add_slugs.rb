class AddSlugs < ActiveRecord::Migration
  def up
    add_column :users, :slug, :string
    add_column :authors, :slug, :string
    add_column :books, :slug, :string
    
    add_index :users, :slug, :unique => true
    add_index :authors, :slug, :unique => true
    add_index :books, :slug, :unique => true
  end
end
