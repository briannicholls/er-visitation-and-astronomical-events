class MoonPhase < ApplicationRecord
  # has_many :visits
  # has_many :diagnoses, through: :visits

  scope :y2019, -> { where('date >= ? AND date < ?', Time.utc(2019).in_time_zone, Time.utc(2020).in_time_zone) }

  scope :full_moons, -> { where('ABS(frac_of_period_from_full_moon) < 0.017') }

  scope :full_moons_2019, -> { MoonPhase.full_moons.where('date >= ? AND date < ?', Time.utc(2019).in_time_zone, Time.utc(2020).in_time_zone) }

  def is_full?
    frac_of_period_from_full_moon.abs < 0.017 ? true : false
  end

  # return collection of visits occuring on date
  def visits
    Visit.where(date: self.date)
  end

  # def self.full_moons_2019
  #   MoonPhase.y2019.select do |e|
  #     e.is_full?
  #   end
  # end

  # show diagnoses and frequency
  def diagnoses
    self.visits.reduce(Hash.new(0)) { |memo, e|
      memo[e.diagnosis.description_long] += 1
      memo }
  end

  def phase

    if self.frac_of_period_from_full_moon < -0.33
      "Waxing Crescent"
    elsif self.frac_of_period_from_full_moon < -0.17
      "Waxing Gibbous"
    elsif self.frac_of_period_from_full_moon < 0.17
      "Full"
    elsif self.frac_of_period_from_full_moon < 0.33
      "Waning Gibbous"
    elsif self.frac_of_period_from_full_moon <= 0.5
      "Waning Crescent"
    else
      nil
    end
  end

end
