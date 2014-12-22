class RemoveDefaultFromOathExp < ActiveRecord::Migration
  def change
    remove_column :users, :oauth_expires_at
  end
end
