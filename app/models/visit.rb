class Visit < ApplicationRecord
  belongs_to :diagnosis, required: false
end
