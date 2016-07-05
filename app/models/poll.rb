class Poll < ApplicationRecord
	serialize :options, Hash
  validates :title, presence: { message: "Must include a title." }
  validates :options, presence: { message: "Must include options." }
  validates :public, presence: { message: "Must include public/private." }
end