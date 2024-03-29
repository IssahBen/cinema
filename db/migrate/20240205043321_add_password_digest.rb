# frozen_string_literal: true

class AddPasswordDigest < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password_digest, :string
  end
end
