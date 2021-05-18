class CreateAsignatures < ActiveRecord::Migration[6.1]
  def change
    create_table :asignatures do |t|
      t.string :name
      t.integer :credits
      t.timestamps
    end
  end
end
