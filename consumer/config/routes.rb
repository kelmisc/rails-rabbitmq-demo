Rails.application.routes.draw do
  post '/consume/start', to: 'consume#start'
  post '/consume/stop', to: 'consume#stop'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
