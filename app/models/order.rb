class Order < ActiveRecord::Base
	self.table_name = :orders

	has_many :ymls
	# has_many :xlsxs

  def create_xlsx_from_ymls
    binding.pry
    Yml.import_from_more_yaml(self.ymls)
  end

end