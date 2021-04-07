class CreateGraphs < ActiveRecord::Migration[6.0]
  def change
    create_table :graphs do |t|
      t.date :date,       null: false
      t.integer :calorie, null: false
      t.timestamps
    end
  end
end
