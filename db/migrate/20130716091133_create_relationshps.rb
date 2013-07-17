class CreateRelationshps < ActiveRecord::Migration
  def change
    create_table :relationshps do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :relationshps ,:follower_id
    add_index :relationshps ,:followed_id
  end

end
