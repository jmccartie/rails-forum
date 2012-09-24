class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :forum_id
      t.string :title
      t.integer :user_id
      t.integer :views

      t.timestamps
    end
  end
end
