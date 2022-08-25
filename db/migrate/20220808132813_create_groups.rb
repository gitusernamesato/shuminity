class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :group_name, null: false, default: ""
      t.text :introduction, null: false#, default: ""
      t.integer :owner_id, null: false#, default: ""
      
      t.timestamps
    end
    add_index :groups, :id, unique: true
  end
end
