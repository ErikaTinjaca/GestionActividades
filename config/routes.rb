Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'asignature#index'
  
  get '/asignature/index'
  get '/asignature/gestion'
  get '/activity/progress'
  get '/activity/resume'
  post '/asignature/create'
  post '/asignature/createActivity'
  post '/asignature/addNote'
  post '/asignature/updateDate'
  post 'activity/addProgress'
  post 'activity/performance'
  post '/activity/progress'
  delete '/asignature/delete'
  delete '/asignature/deleteAll'

  #resources :asignature
end
