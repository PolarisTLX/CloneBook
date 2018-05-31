class AddDefaultValueToRequestAcceptedColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :requests, :accepted, :integer, default: 0
  end
end
