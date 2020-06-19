class CreateDiagnoses < ActiveRecord::Migration[6.0]
  def change
    create_table :diagnoses do |t|
      t.string :code
      t.string :description_long
      t.string :description_short

      t.timestamps
    end
  end
end
