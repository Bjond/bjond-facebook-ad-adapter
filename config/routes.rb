Rails.application.routes.draw do
  root 'bjond_registrations#index'
  post '/facebookad/consequences/createOffer' => 'consequences#createOffer'

  get '/facebookconfigs/bygroup/:groupid' => 'facebookconfigs#by_group_id'
  post '/facebookconfigs/bygroup/:groupid/updatefbaccesstoken' => 'facebookconfigs#update_fb_access_token'
  post '/facebookconfigs/bygroup/:groupid/clearfbaccesstoken' => 'facebookconfigs#clear_fb_access_token'
end
