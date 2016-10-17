class Order < ActiveRecord::Base
	self.table_name = :orders

	has_many :ymls
	# has_many :xlsxs

  def create_xlsx_from_ymls
    files = self.ymls.map(&:yml).map(&:file).map(&:path)
    Yml.import_from_more_yaml( files )
  end

end