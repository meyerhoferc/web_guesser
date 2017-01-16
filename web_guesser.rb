require 'sinatra'
require 'sinatra/reloader'

random_number = rand(99)
get '/' do
  "The SECRET NUMBER is #{random_number}"
end
