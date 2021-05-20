class AddDecimals < ActiveRecord::Migration[6.1]
  def change
    change_column :activities, :note, :decimal, :precision => 10, :scale => 3
  end
end
