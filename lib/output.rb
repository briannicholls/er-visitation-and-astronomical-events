module Output
  require 'csv'

  def self.create_daily_file_from_moon_phase(moon_phase)
    CSV.open("./lib/assets/data/output/analyses/daily/#{moon_phase.date.to_s[0..9]} - #{moon_phase.phase}.csv", 'w') do |row|
      row << ['Date', 'Moon Phase', 'Long Description', 'Short Description', 'Original Code', 'Converted Code']
      moon_phase.visits.each do |visit|
        row << [moon_phase.date.to_s[0..9], moon_phase.phase, visit.diagnosis.description_long, visit.diagnosis.description_short, visit.raw_code, visit.diagnosis.code]
      end
    end
  end

  def self.create_daily_files_from_list(moon_phases)
    moon_phases.each do |mp|
      self.create_daily_file_from_moon_phase(mp)
    end
  end

  def self.create_master_file_for_2019
    CSV.open("./lib/assets/data/output/analyses/year/2019/2019_full_report.csv", 'w') do |row|
      row << ['Date', 'Moon Phase', 'Long Description', 'Short Description', 'Original Code', 'Converted Code']
      MoonPhase.year(2019).each do |mp|
        mp.visits.each do |visit|
          row << [mp.date.to_s[0..9], mp.phase, visit.diagnosis.description_long, visit.diagnosis.description_short, visit.raw_code, visit.diagnosis.code]
        end
      end
    end
  end

end
