class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :url

      t.timestamps
    end

    add_index :pages, :url
  end
end
