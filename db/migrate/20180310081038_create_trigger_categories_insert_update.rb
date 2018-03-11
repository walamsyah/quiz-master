class CreateTriggerCategoriesInsertUpdate < ActiveRecord::Migration[5.1]
  def up
    create_trigger("categories_before_insert_update_row_tr", :generated => true, :compatibility => 1).
        on("categories").
        before(:insert, :update) do
      <<-SQL_ACTIONS
      new.search_text :=       (
        setweight(to_tsvector('simple', replace(coalesce(new.name, ''), '''', '-')), 'A') ||
        setweight(to_tsvector('simple', replace(coalesce(new.description, ''), '''', '-')), 'B')
      );
      SQL_ACTIONS
    end
  end

  def down
    drop_trigger("categories_before_insert_update_row_tr", "categories", :generated => true)
  end
end
