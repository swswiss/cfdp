class SiteSetting < ApplicationRecord
    validates :is_blocked, inclusion: { in: [true, false] }
end
