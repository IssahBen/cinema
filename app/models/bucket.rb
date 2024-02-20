class Bucket < ApplicationRecord
    validates :title, presence: true,length: {minimum:3,maximum:50}
    validates :description, presence: true

    belongs_to :user
    has_many :movies,dependent: :destroy
end
