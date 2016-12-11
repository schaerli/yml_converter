class CreateXlsxs < ActiveRecord::Migration[5.0]
  def change
    create_table :xlsxs do |t|
      t.integer :order_id
      t.string :xls

      t.timestamps
    end
  end
end
