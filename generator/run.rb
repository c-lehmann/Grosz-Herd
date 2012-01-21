require 'sinatra'
require './lib/groszherd'

get '/' do
  'Hello there!'
end

get '/button/:year' do |year|
  headers "Content-Type" => "image/png"
  button = GroszHerd::Button.new year 
  button.render
  button.image.to_blob
end
