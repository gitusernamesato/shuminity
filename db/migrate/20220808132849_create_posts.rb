class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :title, null: false, default: ""
      t.text :body, null: false#, default: ""
      
      t.timestamps
    end
    add_index :posts, :id, unique: true
  end
end
