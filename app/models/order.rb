class Order < ActiveRecord::Base
	self.table_name = :orders

	has_many :ymls
	has_many :xlsxs

  def create_xlsx_from_ymls
    files = self.ymls.map(&:yml).map(&:file).map(&:path)
    Yml.import_from_more_yaml( files )
  end

  def create_yml_from_xlsx
    file = self.xlsxs.map(&:xls).map(&:file).map(&:path)
    Xlsx.create_from_xls(file)
  end


end