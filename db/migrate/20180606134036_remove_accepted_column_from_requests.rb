class RemoveAcceptedColumnFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :accepted
  end
end
