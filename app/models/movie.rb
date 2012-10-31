class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.search(id)
    director = Movie.find_by_id(id).director
    if !director.empty?
      Movie.find_all_by_director(director)
    else
      return nil
    end
  end

end
