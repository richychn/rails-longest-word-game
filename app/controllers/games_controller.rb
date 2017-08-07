require 'longest_word'
class GamesController < ApplicationController
  def game
    @start = Time.now
    @grid = generate_grid(10)
  end
  def score
    @end = Time.now
    @grid = params[:grid].split("")
    @session = run_game(params[:query], @grid, Time.parse(params[:start]), @end)
    @score = @session[:score]
    @message = @session[:message]
  end
end
