Rails.application.routes.draw do

  resources :empire_customers
  resources :master_lists do
    collection {post :import}
    collection do
      get 'remove_all'
      get 'no_mail_add'
      get 'no_mail'
    end
  end

  resources :mailing_empire_nms do
    collection {post :import}
    collection do
      get 'remove_all'
      get 'no_mail'
      get 'data'
    end
  end

  resources :sales do
    collection {post :import}
  end
  resources :task_deadlines
  resources :course_creation_tasks
  resources :empire_courses
  resources :course_creation_templetes
  resources :calendars
  resources :live_chat_answers
  resources :cpe_due_dates do
    collection {post :import}
    end

  resources :course_comments
  resources :call_logs
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
  get 'sequoia/dash_john'

  resources :date_fields
  resources :pes_courses do
    collection {post :import}
    collection do
      get 'remove_all'
    end
  end

  resources :postcard_returns
  get 'sales_report/postcard_return_stats'
  get 'sales_report/call_log_stats'
  get 'sales_report/sequoia_sales'
  get 'sales_report/sequoia_exams'

  get 'test_pages/test_1'

  get 'sales_report/course_status'
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
    collection do
      get 'remove_all'
    end
  end

  root :to => 'home#index'

  # user_signed_in? && current_user.email == 'austin@sequoiacpe.com' ? root :to => "sequoia#dash" : ''
  # user_signed_in? && current_user.email == 'ashley@sequoiacpe.com' ? root :to => "sequoia#dash_ashley" : ''
  # user_signed_in? && current_user.email == 'kyle@sequoiacpe.com' ? root :to => "datasheets#index" : ''
  # user_signed_in? && current_user.email == 'micheal@sequoiacpe.com' ? root :to => "datasheets#index" : ''
  # root :to => "datasheets#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
