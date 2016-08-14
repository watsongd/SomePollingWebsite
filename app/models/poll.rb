class Poll < ApplicationRecord
  has_many :voteips
	serialize :options, Hash
  validates :title, presence: { message: "Must include a title." }
  validates :options, presence: { message: "Must include options." }
  validates_inclusion_of :public, in: [true, false], message: "Must choose public/private."

  def vote(option, password_guess)
    if !is_public?
      if correct_password?(password_guess)
        return vote_on_option(option)
      end
    else
      return vote_on_option(option)
    end
    return false
  end

  def vote_on_option(option)
    @options = options
    @options[option.to_sym] += 1
    if update options: @options, cached_total_votes: cached_total_votes + 1
      return true
    else
      return false
    end
  end

  def is_public?
    return self.public
  end

  def self.create_params_for_poll(params)
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

  private
  def correct_password?(password_guess)
    if password_guess == self.password
      return true
    end
    return false
  end
end