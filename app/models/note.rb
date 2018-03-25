class Note < ApplicationRecord
  has_one :score, as: :scorable
end
