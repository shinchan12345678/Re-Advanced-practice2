class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :owner_id
      t.string :group_name
      t.string :introduction

      t.timestamps
    end
  end
end
