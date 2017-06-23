class FacebookconfigsController < ApplicationController

  def by_group_id
    group_id = params[:groupid]
    @facebook_config = FacebookConfig.find_or_create_by(:group_id => group_id)
    render 'show'
  end

  def update_fb_access_token
    group_id = params[:groupid]
    @facebook_config = FacebookConfig.find_by_group_id(group_id)
    if (@facebook_config.nil?)
      render json: {}.to_json
    else 
      user_access_token = params[:fbaccesstoken]
      @facebook_config.update_attributes(:user_app_token => user_access_token)
      render json: @facebook_config.to_json
    end
  end

  def clear_fb_access_token
    group_id = params[:groupid]
    @facebook_config = FacebookConfig.find_by_group_id(group_id)
    @facebook_config.update_attributes(:user_app_token => nil)
    render 'show'
  end

end