class Api::V1::PollsController < Api::ApiController
  respond_to :xml, :json
  def show
    @poll = Poll.find(params[:id])
    respond_with(@poll, status: 200)
  end
  def create
    begin
      new_params, options_symbols = create_params_for_poll(params)
      params = new_params
      @poll = Poll.new poll_params(options_symbols)
      if @poll.save
        respond_with(@poll, status: 201)
      else
        respond_with(@poll, status: 422)
      end
    rescue NoMethodError
      render json: {error: "improper parameters"}, status: 400
    end
  end
  def vote
    @poll = Poll.find(params[:id])
    if @poll.vote(params[:option], params[:password], request.remote_ip)
      respond_with(@poll, status: 201)
    else
      respond_with(@poll, status: 400)
    end
  end
  def search
    respond_with(Poll.where("title like ?", "%#{params[:query]}%"), status: 200)
  end
end
