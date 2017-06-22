class AddGroupIdToFacebookConfig < ActiveRecord::Migration
  def change
    add_column :facebook_configs, :group_id, :string
  end
end
