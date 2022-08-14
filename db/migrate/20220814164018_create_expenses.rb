class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.time :date
      t.string :establishment
      t.float :value
      t.string :note

      t.timestamps
    end
  end
end
