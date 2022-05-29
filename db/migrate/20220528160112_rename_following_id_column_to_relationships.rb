class RenameFollowingIdColumnToRelationships < ActiveRecord::Migration[6.0]
  def change
    rename_column :relationships, :following_id, :follower_id
  end
end
