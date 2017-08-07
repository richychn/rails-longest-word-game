require 'open-uri'
require 'json'

def generate_grid(grid_size)
  # TODO: generate random grid of letters
  grid = []
  (1..grid_size).each { grid << (65 + rand(26)).chr }
  return grid
end

def run_game(attempt, grid, start_time, end_time)
  # TODO: runs the game and return detailed hash of result
  ans = { time: end_time - start_time, score: 0, message: "" }
  if check_letters(attempt, grid) == false
    ans[:message] = "You're word has letters not in the grid. Please try again."
  elsif check_word(attempt) == false
    ans[:message] = "You're attempt is not an English word. Please try again."
  else
    ans[:score] = attempt.length / (end_time - start_time)
    ans[:message] = "Well done!"
  end
  return ans
end

def check_letters(attempt, grid)
  attempt.upcase.split("").each do |letter|
    return false unless grid.include? letter
    grid.delete_at grid.index(letter)
  end
  return true
end

def check_word(attempt)
  url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
  serialized = open(url).read
  data = JSON.parse(serialized)
  return data["found"] == true
end
