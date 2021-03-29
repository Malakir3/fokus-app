class CreateIntakes < ActiveRecord::Migration[6.0]
  def change
    create_table :intakes do |t|
      t.references :user,     null: false, foreign_key: true
      t.references :menu,     null: false, foreign_key: true
      t.date :date,           null: false
      t.integer :timing_id,   null: false
      t.integer :value_id,    null: false
      t.timestamps
    end
  end
end
