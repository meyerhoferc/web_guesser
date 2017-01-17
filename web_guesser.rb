require 'sinatra'
require 'sinatra/reloader'

# class WebGuesser
# end
NUMBER = rand(100)

def guiding_message(guess)
  return "Way too high!"  if (guess.to_i - NUMBER) > 5
  return "Way too low!"   if (NUMBER - guess.to_i) > 5
  return "Too high!"      if guess.to_i > NUMBER
  "Too low!"              if guess.to_i < NUMBER
end

def win_message
  "You got it right!\nThe SECRET NUMBER is #{NUMBER}"
end

def check_guess(guess)
  return guiding_message(guess) if guess.to_i != NUMBER
  win_message                   if guess.to_i == NUMBER
end

# def new_game
#   counter = 6
#   "You did not guess the secret number in 5 guesses, so a new number has been set. Begin guessing!"
# end

def game_moderator(guess, counter)
  return check_guess(guess) if counter != 0
  # new_game if counter == 0
end

counter = 6


get '/' do
  counter -= 1
  message = game_moderator(params['guess'], counter)
  message = check_guess(params['guess'])
  erb :index, :locals => {:number => NUMBER, :message => message}
end
