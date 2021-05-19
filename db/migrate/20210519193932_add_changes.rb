class AddChanges < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :value, :integer
    add_column :activities, :limitHour, :time
  end
end
