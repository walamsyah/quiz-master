class AddUserIdToQuestionAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :question_answers, :user_id, :integer
  end
end
