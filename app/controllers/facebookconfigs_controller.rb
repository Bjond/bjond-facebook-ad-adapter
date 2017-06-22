class FacebookconfigsController < ApplicationController

  def by_group_id
    group_id = params[:groupid]
    @facebook_config = FacebookConfig.find_or_create_by(:group_id => group_id)
    render 'show'
  end

end