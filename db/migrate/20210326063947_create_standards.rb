class CreateStandards < ActiveRecord::Migration[6.0]
  def change
    create_table :standards do |t|
      t.references :user, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true
      t.integer :large,   null: false
      t.integer :medium,  null: false
      t.integer :small,   null: false
      t.timestamps
    end
  end
end
