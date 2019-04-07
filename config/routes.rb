Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root 'chatroom#show'
end
