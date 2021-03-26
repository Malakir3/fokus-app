class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
      t.string :title,    null: false
      t.integer :amount,  null: false
      t.string :unit,     null: false
      t.integer :calorie, null: false
      t.string :bar_code
      t.timestamps
    end
  end
end
