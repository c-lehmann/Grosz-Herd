require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sass'
require './lib/groszherd'

get '/' do
  erb :index
end

get '/button/:year' do |year|
  begin
    button = GroszHerd::Button.new year 
    
    content_type "image/png"
    headers "Content-disposition" => "attachment; filename=grosz_herd_button_" + year +".png"
    button.image.to_blob
  rescue ArgumentError => e
    content_type "text/plain"
    halt 400, {'Content-Type' => 'text/plain'}, e.message
  end
end

get '/sheet/:year' do |year|
  begin
    sheet = GroszHerd::Sheet.new year 
    
    content_type "image/png"
    headers "Content-disposition" => "attachment; filename=grosz_herd_buttons_" + year +".png"
    sheet.image.to_blob
  rescue ArgumentError => e
    content_type "text/plain"
    halt 400, {'Content-Type' => 'text/plain'}, e.message
  end
end

get '/screen.css' do
  sass :screen
end
