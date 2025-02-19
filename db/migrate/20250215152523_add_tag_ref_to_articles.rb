class AddTagRefToArticles < ActiveRecord::Migration[8.0]
  def change
    add_reference :articles, :tag, null: false, foreign_key: true
  end
end
