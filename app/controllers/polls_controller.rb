class PollsController < ApplicationController
	def show
		@poll = Poll.find(params[:id])
	end
	def vote
		@poll = Poll.find(params[:id])
		@options = @poll.options
		@options[params[:option].to_sym] += 1
		@poll.update options: @options
		redirect_to poll_stats_path(id: params[:id])
	end
	def stats
		@poll = Poll.find(params[:id])
		@keys = @poll.options.keys
		@key_strings = []
		@keys.each do |key|
			@key_strings << key.to_s
		end
		@values = @poll.options.values
		@backgroundColors = []
    @keys.length.times do |i|
      @backgroundColors << "#%06x" % (rand(0xffffff))
    end
	end
	def stats_json
		render json: Poll.find(params[:id]).to_json
	end
end
