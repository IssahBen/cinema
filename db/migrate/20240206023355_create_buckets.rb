# frozen_string_literal: true

class CreateBuckets < ActiveRecord::Migration[6.1]
  def change
    create_table :buckets do |t|
      t.string :title
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
