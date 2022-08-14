class CreateCeaps < ActiveRecord::Migration[6.1]
  def change
    create_table :ceaps do |t|
      t.string :name
      t.time :date
      t.float :total_spend

      t.timestamps
    end
  end
end
