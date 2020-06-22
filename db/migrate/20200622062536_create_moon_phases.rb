class CreateMoonPhases < ActiveRecord::Migration[6.0]
  def change
    create_table :moon_phases do |t|
      t.datetime :date
      t.float :frac_of_period_from_full_moon
    end
  end
end
