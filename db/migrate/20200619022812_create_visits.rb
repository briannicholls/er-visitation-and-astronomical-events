class CreateVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :visits do |t|
      t.datetime :date
      t.datetime :dob
      t.references :diagnosis, foreign_key: true

      t.timestamps
    end
  end
end
