require 'sinatra'
require 'sinatra/reloader'

class WebGuesser
  attr_accessor :counter,
                :number
  def initialize
    @number = rand(100)
    @counter = 6
    @colors = ["backround: green", "background: red", "background: yellow", "background: blue", "background: orange"]
  end

  def guiding_message(guess)
    return [@colors[1], "Way too high!"]  if (guess.to_i - @number) > 5
    return [@colors[2], "Way too low!"]   if (@number - guess.to_i) > 5
    return [@colors[3], "Too high!"]      if guess.to_i > @number
    [@colors[4], "Too low!"]              if guess.to_i < @number
  end

  def win_message
    "You got it right!\nThe SECRET NUMBER is #{@number}"
  end

  def check_guess(guess)
    return guiding_message(guess) if guess.to_i != @number
    [@colors[0], win_message]     if guess.to_i == @number
  end

  def new_game
    @counter = 6
    @number = rand(100)
    "You did not guess the secret number in 5 guesses, so a new number has been set. Begin guessing!"
  end

  def game_moderator(guess, counter)
    return check_guess(guess) if counter != 0
    new_game if counter == 0
  end
end

web_guesser = WebGuesser.new

get '/' do
  web_guesser.counter -= 1
  color, message = web_guesser.game_moderator(params['guess'], web_guesser.counter)
  erb :index, :locals => {:number => web_guesser.number, :message => message, :color => color }
end
