class CreateHtmlElements < ActiveRecord::Migration[5.0]
  def change
    create_table :html_elements do |t|
      t.integer :page_id
      t.integer :name
      t.string :value

      t.timestamps
    end

    add_index :html_elements, :page_id
  end
end
