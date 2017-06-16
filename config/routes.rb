Rails.application.routes.draw do
  root 'bjond_registrations#index'
  post '/facebookad/consequences/' => 'consequences#createAd'
end
