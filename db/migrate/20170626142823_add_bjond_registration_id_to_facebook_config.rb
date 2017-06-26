class AddBjondRegistrationIdToFacebookConfig < ActiveRecord::Migration
  def change
    add_column :facebook_configs, :bjond_registration_id, :string
  end
end
