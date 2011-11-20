# -*- encoding : utf-8 -*-
class OnceForAll < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.text :description
    end
    create_table :authors_books,:id=>false do |t|
      t.integer :author_id,:book_id
    end
    create_table :books do |t|
      t.string :title
    end
    create_table :definitions do |t|
      t.string :name
      t.text :description
      t.text :code
    end
    create_table :theorems do |t|
      t.string :name
      t.text :description
      t.text :code
    end
    create_table :problems do |t|
      t.string :name
      t.text :description
      t.text :code
    end
    create_table :tasks do |t|
      t.integer :user_id
    end
  end
end
