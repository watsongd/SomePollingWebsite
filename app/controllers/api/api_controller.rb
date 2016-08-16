class Api::ApiController < ApplicationController
  protect_from_forgery with: :null_session
  rescue_from 'ActiveRecord::RecordNotFound' do |exception|
    render json: exception, status: 404
  end
end