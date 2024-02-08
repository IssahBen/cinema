class AddBucketIdtoMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :bucket_id, :int
  end
end
