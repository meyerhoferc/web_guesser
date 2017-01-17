require 'sinatra'
require 'sinatra/reloader'

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

get '/' do
  message = check_guess(params['guess'])
  erb :index, :locals => {:number => NUMBER, :message => message}
end
