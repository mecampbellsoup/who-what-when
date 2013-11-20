require 'sidekiq/web'

TextMeLater::Application.routes.draw do
  root 'messages#new'

  post '/messages' => 'messages#create_from_web'
  post '/receive' => 'messages#create_from_text_message'
  
  mount Sidekiq::Web => '/sidekiq'

  
end
