Rails.application.routes.draw do
  root "polls#home"
  resources :polls, only: [:show, :new, :create]
  get "/polls/:id/stats", to: "polls#stats", as: "poll_stats"
  post "/poll/:id/stats/:option", to: "polls#vote", as: "poll_vote"
  get "/trending", to: "polls#trending", as: "poll_trending"
  get "/search", to: "polls#search", as: "poll_search"
  namespace :api do
    namespace :v1 do
      resources :polls, only: [:show, :create]
      post "/poll/:id/stats/:option", to: "polls#vote", as: "api_poll_vote"
      get "/search", to: "polls#search", as: "api_poll_search"
    end
  end
  match '*unmatched_route', to: 'application#raise_not_found!', via: :all
end
