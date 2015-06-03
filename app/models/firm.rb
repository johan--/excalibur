class Firm < ActiveRecord::Base
	has_many :venues
	has_one	 :subscription
	has_many :payments, through: :subscription
	has_many :rosters, as: :rosterable
	has_many :users, through: :rosters,
					 source: :rosterable, source_type: 'Firm'
end
