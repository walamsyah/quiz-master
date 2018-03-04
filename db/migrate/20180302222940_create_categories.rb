class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.string :image
      t.boolean :published, default: true

      t.timestamps
    end
  end
end
