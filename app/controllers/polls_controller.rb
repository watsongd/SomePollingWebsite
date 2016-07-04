class PollsController < ApplicationController
	def show
		@poll = Poll.find(params[:id])
	end
	def vote
		@poll = Poll.find(params[:id])
		@options = @poll.options
		@options[params[:option].to_sym] += 1
		@poll.update options: @options
		redirect_to poll_stats_path(params[:id])
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
		options_hash = Hash.new(0)
		options_symbols = []
		params[:poll][:options].each do |o|
			options_hash[o.to_sym] = 0
			options_symbols << o.to_sym
		end
		params[:poll][:options] = options_hash
		@poll = Poll.new poll_params(options_symbols)
		@poll.save
		redirect_to poll_path(@poll)
	end
	private
	def poll_params(options_symbols)
		params.require(:poll).permit(:title, :public, options: [options_symbols])
	end
end
