Rails.application.routes.draw do
  root "polls#home"
  resources :polls, only: [:show, :new, :create]
  get "/polls/:id/stats", to: "polls#stats", as: "poll_stats"
  post "/poll/:id/stats/:option", to: "polls#vote", as: "poll_vote"
  get "/polls/:id/stats/.json", to: "polls#stats_json", as: "poll_stats_json"
  get "/trending", to: "polls#trending", as: "poll_trending"
  get "/search", to: "polls#search", as: "poll_search"
end
