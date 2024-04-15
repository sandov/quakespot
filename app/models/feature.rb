class Feature < ApplicationRecord
    validates_uniqueness_of :extern_id

    validates :title, presence: true
    validates :external_url, presence: true
    validates :place, presence: true

    validates :mag_type, presence: true,  numericality: { greater_than: -1, less_than: 10 }
    validates :coord_long, presence: true, numericality: { greater_than: -180, less_than: 180 }
    validates :coord_lat, presence: true, numericality: { greater_than: -90, less_than: 90 }
end
