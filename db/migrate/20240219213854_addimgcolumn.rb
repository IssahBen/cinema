class Addimgcolumn < ActiveRecord::Migration[6.1]
  def change
      add_column :movies, :src, :string
  end
end
