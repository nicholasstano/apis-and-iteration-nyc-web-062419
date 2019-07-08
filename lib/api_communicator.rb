require 'rest-client'
require 'json'
require 'pry'

  def get_results_array
    i = 1
    final_hash = []
    while i < 10 
      response_string = RestClient.get("https://swapi.co/api/people/?page=#{i}")
      response_hash = JSON.parse(response_string)
      final_hash = final_hash.concat(response_hash["results"])
      i += 1
    end
    final_hash
  end

  def show_character_movies(character)
    films = get_character_movies_from_api(character)
    print_movies(films)
  end

  def get_character_movies_from_api(character_name)
  #make the web request
    url_array = get_results_array.find do |character_instance|
      character_instance["name"].to_s.downcase == character_name
    end
    character_film_array = url_array["films"].map do |url_instance|
    movie_string = RestClient.get(url_instance)
    movie_array = JSON.parse(movie_string)
    end
    character_film_array.map do |character_film_instance|
      character_film_instance["title"]
    end
    
  end
 
  def print_movies(films)
    # some iteration magic and puts out the movies in a nice list
    films.each do |film_array|
      puts film_array
    end
  end



## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
