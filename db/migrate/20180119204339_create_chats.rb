class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.string :username, null: false
      t.string :text, null: false
      t.integer :timeout, default: 60
      t.timestamps
    end
  end
end
