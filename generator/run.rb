require 'sinatra'
require './lib/groszherd'

get '/' do
  erb :index
end

get '/button/:year' do |year|
  begin
    content_type "image/png"
    headers "Content-disposition" => "attachment; filename=grosz_herd_button_" + year +".png"
    button = GroszHerd::Button.new year 
    button.image.to_blob
  rescue ArgumentError => e
    halt 400, {'Content-Type' => 'text/plain'}, e.message
  end
end

get '/sheet/:year' do |year|
  begin
    content_type "image/png"
    headers "Content-disposition" => "attachment; filename=grosz_herd_buttons_" + year +".png"
    sheet = GroszHerd::Sheet.new year 
    sheet.image.to_blob
  rescue ArgumentError => e
    halt 400, {'Content-Type' => 'text/plain'}, e.message
  end
end
