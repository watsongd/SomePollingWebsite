class Poll < ApplicationRecord
	serialize :options, Hash
  validates :title, presence: { message: "Must include a title." }
  validates :options, presence: { message: "Must include options." }
  validates_inclusion_of :public, in: [true, false], message: "Must choose public/private."
  def vote(option)
    @options = options
    @options[option.to_sym] += 1
    if update options: @options, cached_total_votes: cached_total_votes + 1
      return true
    else
      return false
    end
  end
end