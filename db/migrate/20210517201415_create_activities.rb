class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :description
      t.date :sendDate
      t.integer :advance
      t.decimal :note
      t.references :asignature, null: false, foreign_key: true
      t.timestamps
    end
  end
end