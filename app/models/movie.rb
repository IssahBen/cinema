# frozen_string_literal: true

class Movie < ApplicationRecord
  belongs_to :bucket
end
