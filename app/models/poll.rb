class Poll < ApplicationRecord
  has_many :votes
	serialize :options, Hash
  validates :title, presence: { message: "Must include a title." }
  validates :options, presence: { message: "Must include options." }
  validates_inclusion_of :public, in: [true, false], message: "Must choose public/private."

  def vote(option, password_guess, user_ip)
    if !(get_vote_ips.include? user_ip)
      if !is_public?
        if correct_password?(password_guess)
          return vote_on_option(option, user_ip)
        end
      else
        return vote_on_option(option, user_ip)
      end
    end
    return false
  end

  def vote_on_option(option, user_ip)
    Vote.create(ip: user_ip, poll_id: id)
    @options = options
    if @options[option.to_sym]
      @options[option.to_sym] += 1
    else
      return false
    end
    if update options: @options, cached_total_votes: cached_total_votes + 1
      return true
    else
      return false
    end
  end

  def is_public?
    return self.public
  end

  def get_vote_ips
    ips = []
    for vote in votes
      ips << vote.ip
    end
    return ips
  end

  private
  def correct_password?(password_guess)
    if password_guess == self.password
      return true
    end
    return false
  end
end