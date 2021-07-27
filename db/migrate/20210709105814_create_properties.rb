class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :address
      t.decimal :monthly_price
      t.text :description
      t.boolean :is_for_rent
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
