require 'sinatra'
require 'sinatra/reloader'

class WebGuesser
  attr_accessor :counter,
                :number
  def initialize
    @number = rand(100)
    @counter = 6
  end

  def guiding_message(guess)
    return "Way too high!"  if (guess.to_i - @number) > 5
    return "Way too low!"   if (@number - guess.to_i) > 5
    return "Too high!"      if guess.to_i > @number
    "Too low!"              if guess.to_i < @number
  end

  def win_message
    "You got it right!\nThe SECRET NUMBER is #{@number}"
  end

  def check_guess(guess)
    return guiding_message(guess) if guess.to_i != @number
    win_message                   if guess.to_i == @number
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

webguesser = WebGuesser.new

get '/' do
  webguesser.counter -= 1
  message = webguesser.game_moderator(params['guess'], webguesser.counter)
  erb :index, :locals => {:number => webguesser.number, :message => message}
end
