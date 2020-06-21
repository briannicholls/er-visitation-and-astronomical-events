class Visit < ApplicationRecord
  belongs_to :diagnosis, required: false

  scope :unassigned, -> { where(:diagnosis_id => nil) }
end
