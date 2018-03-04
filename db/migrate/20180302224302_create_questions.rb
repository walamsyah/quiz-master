class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.integer :category_id, null: false
      t.text :content
      t.string :answer
      t.string :image
      t.boolean :published, default: true
      t.integer :position, default: 1

      t.timestamps
    end
  end
end
