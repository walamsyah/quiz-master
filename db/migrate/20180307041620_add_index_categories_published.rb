class AddIndexCategoriesPublished < ActiveRecord::Migration[5.1]
  disable_ddl_transaction!

  def up
    execute <<-SQL.strip_heredoc
      CREATE INDEX CONCURRENTLY IF NOT EXISTS index_categories_published ON categories (id) WHERE published;
    SQL
  end

  def down
    execute <<-SQL.strip_heredoc
      DROP INDEX IF EXISTS index_categories_published;
    SQL
  end
end
