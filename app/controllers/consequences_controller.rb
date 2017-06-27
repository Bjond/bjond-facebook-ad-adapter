class ConsequencesController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:create_offer]

  def create_offer
    registration = BjondRegistration.find_registration_by_remote_request(request)
    fb_config = FacebookConfig.find_by_bjond_registration_id_and_group_id(registration.id, params['groupid'])
    user_graph = Koala::Facebook::API.new(fb_config.user_app_token)
    pages = user_graph.get_connections('me', 'accounts')
    
    ## For simplicity, just using first page found for user. If the user manages multiple pages, 
    ## we may need to store the page ID in the FacebookConfig object.
    page_access_token = pages[0]["access_token"]
    page_graph = Koala::Facebook::API.new(page_access_token)
    page_graph.get_connection('me')
    # binding.pry
    puts 'Received consequence callback form Bjond server'
    render :json => {:status => 'ok'}
  end
end
