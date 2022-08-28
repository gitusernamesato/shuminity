class ChatMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_messages do |t|
      t.string :message, null: false
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      
      t.timestamps
    end
    add_index :chat_messages, :id, unique: true
  end
end
