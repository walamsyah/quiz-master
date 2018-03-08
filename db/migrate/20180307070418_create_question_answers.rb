class CreateQuestionAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :question_answers do |t|
      t.integer :category_id
      t.integer :question_id
      t.string :answer
      t.string :category_token
      t.boolean :is_correct

      t.timestamps
    end
  end
end
