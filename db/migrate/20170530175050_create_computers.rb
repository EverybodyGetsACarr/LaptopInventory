class CreateComputers < ActiveRecord::Migration[5.0]
  def change
    create_table :computers do |t|
      t.string :name
      t.integer :status, default: 0
        # 1 = in use
        # 2 = available
        # 3 = destroyed
      t.boolean :history, default: false
      t.string :owner
      t.integer :manufacturer
      t.string :model
      t.string :serial
      t.string :product
      t.float :space
      t.float :processor
      t.float :ram
      t.integer :computer_id
      t.text :comments
      t.string :comment_author
      t.string :wired_mac
      t.string :wireless_mac

      t.timestamps
    end
  end
end
