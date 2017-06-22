Rails.application.routes.draw do
  root 'bjond_registrations#index'
  post '/facebookad/consequences/createOffer' => 'consequences#createOffer'

  get '/facebookconfigs/bygroup/:groupid' => 'facebookconfigs#by_group_id'
end
