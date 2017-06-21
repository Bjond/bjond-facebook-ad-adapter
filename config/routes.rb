Rails.application.routes.draw do
  root 'bjond_registrations#index'
  post '/facebookad/consequences/createOffer' => 'consequences#createOffer'
end
