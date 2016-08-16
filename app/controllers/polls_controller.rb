class PollsController < ApplicationController
	def show
		@poll = Poll.find(params[:id])
		@password = params[:password]
		@already_voted = @poll.get_vote_ips.include? request.remote_ip
	end
	def vote
		if Poll.find(params[:id]).vote(params[:option], params[:password], request.remote_ip)
			redirect_to poll_stats_path(params[:id])
		else
			redirect_to poll_path(params[:id]), alert: "error in voting. you may have already voted, or this poll is private and you do not have the password."
		end
	end
	def stats
    @poll, @key_strings, @values, @backgroundColors, @backgroundColorsBar, @borderColorsBar = setup_stats(params[:id])
	end
	def new
		@poll = Poll.new
	end
	def create
		begin
			new_params, options_symbols = create_params_for_poll(params)
			params = new_params
			@poll = Poll.new poll_params(options_symbols)
			if @poll.save
			  redirect_to poll_path(@poll, password: @poll.password)
			else
				redirect_to new_poll_path, alert: @poll.errors
			end
		rescue NoMethodError
			redirect_to new_poll_path, alert: "invalid input values"
		end
	end
	def home
	end
	def trending
		@top_polls = Poll.where(public: true).order(cached_total_votes: :desc).first(10)
	end
	def new_search
	end
	def search
		@page = params[:page]
		@query = params[:query]
		if @page == nil || @query == nil || @query == ""
			render "new_search"
		end
		@polls, @num_of_pages = query(params[:page].to_i, params[:query])
	end
end
