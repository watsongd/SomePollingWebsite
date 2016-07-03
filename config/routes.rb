Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/poll/:id", to: "polls#show"
  post "/poll/:id/stats/:option", to: "polls#vote", as: "poll_vote"
end
