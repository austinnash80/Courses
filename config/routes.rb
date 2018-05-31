Rails.application.routes.draw do
  devise_for :users
  # get 'updatesheets/:id/', to: redirect("/updatesheets")
  resources :updatesheets
  resources :datasheets do
    collection {post :import}
  end
  root :to => "datasheets#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
