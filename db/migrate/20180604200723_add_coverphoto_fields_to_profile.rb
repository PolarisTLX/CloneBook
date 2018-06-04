class AddCoverphotoFieldsToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :cover_file_name,     :string
    add_column :profiles, :cover_content_type,  :string
    add_column :profiles, :cover_file_size,     :integer
    add_column :profiles, :cover_updated_at,    :datetime
  end
end
