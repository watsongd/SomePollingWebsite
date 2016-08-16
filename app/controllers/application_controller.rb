class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def setup_stats(poll_id)
    poll = Poll.find(poll_id)
    key_strings = poll.options.keys.map { |k| k.to_s }
    values = poll.options.values
    backgroundColors = []
    backgroundColorsBar = []
    borderColorsBar = []
    random = Random.new
    poll.options.length.times do
      r = random.rand(256).to_s
      g = random.rand(256).to_s
      b = random.rand(256).to_s
      backgroundColorsBar << 'rgba(' + r + ', ' + g + ', ' + b + ', ' + '0.4)'
      borderColorsBar << 'rgba(' + r + ', ' + g + ', ' + b + ', ' + '1)'
      backgroundColors << 'rgba(' + r + ', ' + g + ', ' + b + ', ' + '1)'
    end
    return poll, key_strings, values, backgroundColors, backgroundColorsBar, borderColorsBar
  end
  def query(page_num, query_string)
    polls = Poll.where("title like ?", "%#{query_string}%")
    num_of_pages = polls.length == 0 ? 1 : (polls.length - 1) / 10 + 1
    polls = polls[(page_num * 10 - 10)..(page_num * 10)]
    return polls, num_of_pages
  end
  private
  def poll_params(options_symbols)
    params.require(:poll).permit(:title, :public, :password, options: [options_symbols])
  end
  def create_params_for_poll(params)
    if params[:poll][:public] == "false"
      params[:poll][:password] = SecureRandom.hex(10)
    end
    options_hash = Hash.new(0)
    options_symbols = []
    params[:poll][:options].each do |o|
      options_hash[o.to_sym] = 0
      options_symbols << o.to_sym
    end
    options_hash.delete(:"")
    params[:poll][:options] = options_hash
    return params, options_symbols
  end
end
