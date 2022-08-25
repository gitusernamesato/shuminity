class CreateChatGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_groups do |t|
      t.references :chat, foreign_key: true
      t.references :group, foreign_key: true
      
      t.timestamps
    end
    add_index :chat_groups, :id, unique: true
  end
end
