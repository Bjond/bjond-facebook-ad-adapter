class RenameUseAppToken < ActiveRecord::Migration
  def change
    rename_column :facebook_configs, :useAppToken, :user_app_token
    rename_column :facebook_configs, :facebookAppId, :facebook_app_id
    rename_column :facebook_configs, :facebookAppSecret, :facebook_app_secret
  end
end
