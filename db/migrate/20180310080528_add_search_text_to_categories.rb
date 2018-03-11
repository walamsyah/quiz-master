class AddSearchTextToCategories < ActiveRecord::Migration[5.1]
  def up
    add_column :categories, :search_text, :tsvector
    add_index :categories, :search_text, using: 'gin'
  end

  def down
    remove_column :categories, :search_text
    remove_index :categories, :search_text
  end
end
