class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.string :comment, null: false, default: ""
      
      t.timestamps
    end
    add_index :comments, :id, unique: true
  end
end
