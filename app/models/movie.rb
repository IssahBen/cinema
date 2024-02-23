class Movie < ApplicationRecord
    belongs_to :bucket
    validates :title , uniqueness: true 
end
