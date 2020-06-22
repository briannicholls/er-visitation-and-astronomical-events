class MoonPhase < ApplicationRecord

  scope :y2019, -> { where('date >= ? AND date < ?', Time.utc(2019).in_time_zone, Time.utc(2020).in_time_zone) }

end
