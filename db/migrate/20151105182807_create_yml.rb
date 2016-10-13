class CreateYml < ActiveRecord::Migration
  def change
    create_table :ymls do |t|
    	t.integer :order_id
      t.string :yml

      t.timestamps
    end
  end
end
