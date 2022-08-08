class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.text :message, null: false, default: ""

      t.timestamps
    end
  end
end
