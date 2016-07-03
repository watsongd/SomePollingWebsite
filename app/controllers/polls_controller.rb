class PollsController < ApplicationController
	def show
		@poll = Poll.find(params[:id])
	end
	def vote
		@poll = Poll.find(params[:id])
		@options = @poll.options
		puts @options
		@options[params[:option].to_sym] += 1
		@poll.update options: @options 
		redirect_to action: "show", id: params[:id]
	end
end
