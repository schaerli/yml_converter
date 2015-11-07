class CreateYml < ActiveRecord::Migration
  def change
    create_table :ymls do |t|
      t.string :yml
    end
  end
end
