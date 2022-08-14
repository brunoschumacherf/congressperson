class AddDeputyToExpense < ActiveRecord::Migration[6.1]
  def change
    add_reference :expenses, :deputy, null: false, foreign_key: true
  end
end
