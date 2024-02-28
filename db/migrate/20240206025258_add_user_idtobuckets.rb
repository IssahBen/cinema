# frozen_string_literal: true

class AddUserIdtobuckets < ActiveRecord::Migration[6.1]
  def change
    add_column :buckets, :user_id, :int
  end
end
