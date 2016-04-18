flight_time = 

class MovieEntertainment
  def initialize(flight_time:, movie_lenghts:)
    @flight_time = flight_time
    @movie_lenghts = movie_lenghts
  end

  def find_movies
    i = 0
    acceptable_movies = []
    while i < movie_lenghts.length
      movie_lenghts.each_with_index do |m_l, index|
        next if index == i
        acceptable_movies << "the two movies are #{movie_lenghts[i]} and #{m_l}" if movie_lenghts[i] + m_l == flight_time
      end
      movie_lenghts.shift
      i += 1
    end
    puts acceptable_movies
  end

  private

  attr_reader :flight_time, :movie_lenghts
end

m_l = [2, 5, 6, 7, 8, 9, 10].sort

MovieEntertainment.new(flight_time: 11, movie_lenghts: m_l).find_movies

