class CreateJoinTableMoviesRecommendations < ActiveRecord::Migration[5.1]
  def change
    create_join_table :movies, :recommendations do |t|
      t.index [:movie_id, :recommendation_id]
      t.index [:recommendation_id, :movie_id]
    end
  end
end
