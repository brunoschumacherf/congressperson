class CreateDeputies < ActiveRecord::Migration[6.1]
  def change
    create_table :deputies do |t|
      t.string :name
      t.string :state
      t.string :document

      t.timestamps
    end
  end
end
