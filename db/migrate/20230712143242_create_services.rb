class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name, null: false, default: ""
      t.decimal :price, default: 0
      t.string :image, null: false, default: ""
      t.text :details, null: false, default: ""
      t.integer :duration, default: 0

      t.timestamps
    end
  end
end
