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
		@poll = Poll.find(params[:id])
		@key_strings = []
		@poll.options.keys.each do |key|
			@key_strings << key.to_s
		end
		@values = @poll.options.values
		@backgroundColors = []
		@backgroundColorsBar = []
		@borderColorsBar = []
    random = Random.new
    @key_strings.length.times do
    	r = random.rand(256).to_s
    	g = random.rand(256).to_s
    	b = random.rand(256).to_s
    	@backgroundColorsBar << 'rgba(' + r + ', ' + g + ', ' + b + ', ' + '0.2)'
    	@borderColorsBar << 'rgba(' + r + ', ' + g + ', ' + b + ', ' + '1)'
    	@backgroundColors << 'rgba(' + r + ', ' + g + ', ' + b + ', ' + '1)'
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
		@num_of_pages = @polls.length == 0 ? 1 : (@polls.length - 1) / 10 + 1
		@polls = @polls[(@page.to_i * 10 - 10)..(@page.to_i * 10)]
	end
	private
	def poll_params(options_symbols)
		params.require(:poll).permit(:title, :public, :password, options: [options_symbols])
	end
end
