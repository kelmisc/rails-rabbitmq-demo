Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'transaction/produce', to: 'producer#start'
  post 'transaction/stop', to: 'producer#stop'
end
