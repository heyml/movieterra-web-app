class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.integer :planetakino_id, unique: true

      t.timestamps
    end
  end
end
