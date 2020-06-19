class AddRawCodeToVisit < ActiveRecord::Migration[6.0]
  def change
    add_column :visits, :raw_code, :string
  end
end
