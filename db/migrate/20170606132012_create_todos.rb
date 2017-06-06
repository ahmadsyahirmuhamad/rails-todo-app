class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos, id: :uuid  do |t|
      t.uuid :user_id
      t.string :title
      t.string :description
      t.boolean :complete, default: false
      t.timestamps null: false
    end
  end
end
