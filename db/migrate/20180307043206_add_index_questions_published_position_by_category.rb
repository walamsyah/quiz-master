class AddIndexQuestionsPublishedPositionByCategory < ActiveRecord::Migration[5.1]
  disable_ddl_transaction!

  def up
    execute <<-SQL.strip_heredoc
      CREATE INDEX CONCURRENTLY IF NOT EXISTS index_questions_published_position_by_category ON questions (category_id, position ASC NULLS LAST) WHERE published;
    SQL
  end

  def down
    execute <<-SQL.strip_heredoc
      DROP INDEX IF EXISTS index_questions_published_position_by_category;
    SQL
  end
end
