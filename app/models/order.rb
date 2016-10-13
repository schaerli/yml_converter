class Order < ActiveRecord::Base
	self.table_name = :orders

	has_many :ymls
	# has_many :xlsxs

end