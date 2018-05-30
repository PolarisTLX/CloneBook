class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :requester_id, index: true
      t.integer :requestee_id, index: true
      t.integer :accepted

      t.timestamps
    end
  end
end
