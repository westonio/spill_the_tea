class CreateTeas < ActiveRecord::Migration[7.0]
  def change
    create_table :teas do |t|
      t.string :name
      t.string :description
      t.string :brew_temp
      t.string :brew_time
      t.references :subscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end
