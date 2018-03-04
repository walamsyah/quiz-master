require 'rails_helper'

RSpec.describe "dashboard/categories/_form.html.slim", type: :view do
  context "create new category" do
    it "will render form input and partial form_errors" do
      category = build :category
      render "dashboard/categories/form", category: category

      expect(rendered).to render_template partial: "shared/_form_errors", locals:  { data: category }
      expect(rendered).to have_selector "form#new_category"
      expect(rendered).to have_selector "input#category_name[required=required]"
      expect(rendered).to have_selector "textarea#category_description"
      expect(rendered).to have_selector "input#category_published[type=checkbox]"
      expect(rendered).to have_selector "input[type=submit][value='Create Category']"
    end
  end

  context "edit category" do
    it "will render form input and partial form_errors" do
      category = create :category
      render "dashboard/categories/form", category: category

      expect(rendered).to render_template partial: "shared/_form_errors", locals:  { data: category }
      expect(rendered).to have_selector "form#edit_category_#{category.id}"
      expect(rendered).to have_selector "input[type=submit][value='Update Category']"
      expect(rendered).to have_selector "input#category_name[required=required]"
      expect(rendered).to have_selector "textarea#category_description"
      expect(rendered).to have_selector "input#category_published[type=checkbox]"
    end
  end
end
