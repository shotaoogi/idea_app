# frozen_string_literal: true

class AddCategoriesAndIdeas < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false, unique: true

      t.timestamps
    end

    create_table :ideas do |t|
      t.references :category, null: false, foreign_key: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
