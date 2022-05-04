class AddIndexRelationshipsFollowerId < ActiveRecord::Migration[6.1]
  def change
    add_index :relationships,[:followed_id,:follower_id],unique: true
    add_index :relationships, :followed_id
    add_index :relationships, :follower_id
  end
end
