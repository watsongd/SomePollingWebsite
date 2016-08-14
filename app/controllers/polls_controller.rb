class PollsController < ApplicationController
	def show
		@poll = Poll.find(params[:id])
		@password = params[:password]
	end
	def vote
		if Poll.find(params[:id]).vote(params[:option], params[:password])
			redirect_to poll_stats_path(params[:id])
		else
			redirect_to poll_path(params[:id]), alert: "wrong password for private poll"
		end
	end
	def stats
		@poll = Poll.find(params[:id])
		@key_strings = []
		@poll.options.keys.each do |key|
			@key_strings << key.to_s
		end
		@values = @poll.options.values
		@backgroundColors = []
    @key_strings.length.times do |i|
      @backgroundColors << "#%06x" % (rand(0xffffff))
    end
	end
	def stats_json
		render json: Poll.find(params[:id]).to_json
	end
	def new
		@poll = Poll.new
	end
	def create
		begin
			new_params, options_symbols = Poll.create_params_for_poll(params)
			params = new_params
			@poll = Poll.new poll_params(options_symbols)
			if @poll.save
			  redirect_to poll_path(@poll, password: @poll.password)
			else
				redirect_to new_poll_path, alert: @poll.errors
			end
		rescue NoMethodError
			redirect_to new_poll_path, alert: "incorrect input values"
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
		if @page == nil || @query == nil
			render "new_search"
		end
		@polls = Poll.where("title like ?", "%#{params[:query]}%")
		@num_of_pages = @polls.length / 10 + 1
		@polls = @polls[(@page.to_i * 10 - 10)..(@page.to_i * 10)]
	end
	private
	def poll_params(options_symbols)
		params.require(:poll).permit(:title, :public, :password, options: [options_symbols])
	end
end
