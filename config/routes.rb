require 'sidekiq/web'

TextMeLater::Application.routes.draw do
  root 'messages#new'

  post '/messages' => 'messages#create'
  
  mount Sidekiq::Web => '/sidekiq'

  
end
