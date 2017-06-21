class CreateFacebookConfigs < ActiveRecord::Migration
  def change
    create_table :facebook_configs do |t|
      t.string :facebookAppId
      t.string :facebookAppSecret
      t.string :useAppToken

      t.timestamps null: false
    end
  end
end
