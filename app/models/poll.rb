class Poll < ApplicationRecord
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
  private
  def correct_password?(password_guess)
    if password_guess == self.password
      return true
    end
    return false
  end
end