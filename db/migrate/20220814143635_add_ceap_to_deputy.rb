class AddCeapToDeputy < ActiveRecord::Migration[6.1]
  def change
    add_reference :deputies, :ceap, null: false, foreign_key: true
  end
end
