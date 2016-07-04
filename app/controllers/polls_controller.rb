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
		@poll = Poll.new poll_params
		@poll.save
		redirect_to poll_stats_path(@poll)
	end
	private
	def poll_params
		params.require(:poll).permit(:options, :title, :public)
	end
end
