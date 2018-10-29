Rails.application.routes.draw do
  resources :seq_no_mails do
    collection {post :import}
    collection do
      get 'remove_all'
    end
  end
  # get 'exam_results/index'
  # get 'exam_results/import' => 'exam_results#my_import'
  resources :exam_results do
    collection {post :import}
    collection do
      get 'remove_all'
    end
  end
  get 'exam_results/index0'
  resources :email_campaigns
  resources :inventories
  resources :postcard_mailings
  resources :tx_royalties
  resources :empire_mailings
  resources :mailings do
    collection {post :import}
    collection do
      get 'remove_all'
    end
  end
  resources :tasks
  # resources :sequoia_customers
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'sequoia/dash'
  get 'sequoia/dash_ashley'
  get 'sequoia/dash_michael'
  get 'sequoia/dash_hamdo'
  get 'sequoia/dash_kyle'

  resources :date_fields
  resources :pes_courses
  resources :postcard_returns
  get 'sales_report/sequoia_sales'
  get 'sales_report/sequoia_exams'
  get 'sequoia_customers/index'
  
  get 'sequoia_customers/import' => 'sequoia_customers#my_import'
  resources :sequoia_customers do
    collection {post :import}
    collection do
      get 'remove_all'
    end
  end

  get 'sequoia_exams/import' => 'sequoia_exams#my_import'
  resources :sequoia_exams do
    collection {post :import}
    collection do
      get 'remove_all'
    end
  end

  get 'empire/dash'

  get 'empire/dash'
  resources :copyrights
  devise_for :users
  # get 'updatesheets/:id/', to: redirect("/updatesheets")
  resources :updatesheets
  resources :datasheets do
    collection {post :import}
  end

  root :to => 'home#index'

  # user_signed_in? && current_user.email == 'austin@sequoiacpe.com' ? root :to => "sequoia#dash" : ''
  # user_signed_in? && current_user.email == 'ashley@sequoiacpe.com' ? root :to => "sequoia#dash_ashley" : ''
  # user_signed_in? && current_user.email == 'kyle@sequoiacpe.com' ? root :to => "datasheets#index" : ''
  # user_signed_in? && current_user.email == 'micheal@sequoiacpe.com' ? root :to => "datasheets#index" : ''
  # root :to => "datasheets#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
