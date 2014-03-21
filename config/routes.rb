DailyMood::Application.routes.draw do
  
  devise_for :users, controllers: {registrations: 'registrations'}
  root to: 'home#index'

  resources :moods, only: [:index] do
    collection do
      match 'update_from_email', to: 'moods#update_from_email', via: [:get, :post]
    end
  end

  ####    BACKOFFICE    ####
  scope '/backoffice' do
    devise_for :admins, 
      path: '', 
      path_names: { sign_in: "login", sign_out: "logout" }, 
      controllers: { sessions: "backoffice/sessions" }
  end

  namespace 'backoffice' do 
    root to: 'home#dashboard'
    resources :admins
    resources :users, only: [:index]
  end

  devise_for :admins, skip: :all
  #### END OF BACKOFFICE ####
end
