class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :user, index: true, foreign_key: { on_delete: :cascade }
      t.references :property, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
