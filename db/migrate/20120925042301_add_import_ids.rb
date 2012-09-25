class AddImportIds < ActiveRecord::Migration
  def up
    add_column :users, :import_id, :integer
    add_column :forums, :import_id, :integer
    add_column :topics, :import_id, :integer
    add_column :posts, :import_id, :integer

    add_index :users, :import_id
    add_index :forums, :import_id
    add_index :topics, :import_id
    add_index :posts, :import_id
  end

  def down
    remove_index :users, :import_id
    remove_index :forums, :import_id
    remove_index :topics, :import_id
    remove_index :posts, :import_id

    remove_column :users, :import_id
    remove_column :forums, :import_id
    remove_column :topics, :import_id
    remove_column :posts, :import_id
  end
end
