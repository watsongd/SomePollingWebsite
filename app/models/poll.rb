class Poll < ApplicationRecord
	serialize :options, Hash
end