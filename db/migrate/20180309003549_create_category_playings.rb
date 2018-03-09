class CreateCategoryPlayings < ActiveRecord::Migration[5.1]
  def change
    create_table :category_playings do |t|
      t.integer :category_id
      t.integer :user_id
      t.string :category_token
      t.integer :total_questions
      t.integer :total_corrects
      t.decimal :point

      t.timestamps
    end
  end
end
