module Output
  require 'csv'

  def self.create_readout_from_moon_phase(moon_phase)
    CSV.open("./lib/assets/data/output/analyses/#{moon_phase.date.to_s[0..9]} - #{moon_phase.phase}.csv", 'w') do |row|
      row << ['Date', 'Moon Phase', 'Long Description', 'Short Description', 'Original Code', 'Converted Code']
      moon_phase.visits.each do |visit|
        row << [moon_phase.date.to_s[0..9], moon_phase.phase, visit.diagnosis.description_long, visit.diagnosis.description_short, visit.raw_code, visit.diagnosis.code]
      end
    end
  end

  def self.create_reports_from_list(moon_phases)
    moon_phases.each do |mp|
      self.create_readout_from_moon_phase(mp)
    end
  end

end
