class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.string :date
      t.string :establishment
      t.float :value
      t.string :note
      t.string :phone
      t.string :document

      t.timestamps
    end
  end
end
