class Visit < ApplicationRecord
  belongs_to :diagnosis, required: false

  scope :unassigned, -> { where(:diagnosis_id => nil) }
  # scope :moon_phase, -> {MoonPhase.where(date: self.date)}

  def moon_phase
    MoonPhase.find_by(date: self.date)
  end

  def occured_during_full_moon?
    self.moon_phase.is_full? ? true : false
  end

end
