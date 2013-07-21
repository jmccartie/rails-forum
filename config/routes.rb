Socalbouldering::Application.routes.draw do

  resources :forums do
    resources :topics do
      resources :posts
    end
  end

  devise_for :users, :controllers => {:registrations => "users/registrations" }

  root :to => 'forums#index'

end
