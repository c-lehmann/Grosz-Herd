require './lib/groszherd'

if ARGV[1] == "button"
  button = GroszHerd::Button.new ARGV[0]
  puts button.image.to_blob
else
  sheet = GroszHerd::Sheet.new ARGV[0]
  puts sheet.image.to_blob
end