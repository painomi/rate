class Score < ApplicationRecord
  belongs_to :scorable, polymorphic: true
end
