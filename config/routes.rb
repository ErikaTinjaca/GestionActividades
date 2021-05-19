Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'asignature#index'
  get '/asignature/index'
  get '/asignature/gestion'
  get '/activity/progress'
  get '/activity/resume'
end
