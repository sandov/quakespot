class Feature < ApplicationRecord
    has_many :comments

    validates_uniqueness_of :extern_id

    validates :title, presence: true
    validates :external_url, presence: true
    validates :place, presence: true

    validates :mag_type, presence: true
    validates :magnitude, numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 10 }
    validates :coord_long, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
    validates :coord_lat, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
end
