require 'csv'

def create_moon_phase_from_row(row)
  # year, month, day, period, frac_of_period_from_full_moon
  MoonPhase.create(
    date: DateTime.new(row[0].to_i, row[1].to_i, row[2].to_i),
    frac_of_period_from_full_moon: row[4].to_f
  )
end

def create_moon_phases_from_csv
  data = CSV.read('./lib/assets/data/output/moon_phases_all.csv')
  data[1..data.length-1].each do |row|
    create_moon_phase_from_row(row)
  end
end

# def generate_csv(data)
#   CSV.open('./lib/assets/data/output/moon_phases_all.csv', 'w') do |row|
#     data.each do |datarow|
#       row << datarow
#     end
#   end
# end
