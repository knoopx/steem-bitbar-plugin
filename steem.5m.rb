#!/usr/bin/env ruby
# <bitbar.title>STEEM</bitbar.title>
# <bitbar.version>1.0</bitbar.version>
# <bitbar.author>Víctor Martínez</bitbar.author>
# <bitbar.author.github>knoopx</bitbar.author.github>
# <bitbar.desc>Steem ticker</bitbar.desc>
# <bitbar.dependencies>ruby</bitbar.dependencies>
# <bitbar.abouturl>http://knoopx.net/</bitbar.abouturl>

require 'json'
require 'open-uri'
json = JSON.parse(open("https://api.coinmarketcap.com/v1/ticker/steem/").read)[0]

IMAGE_UP = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QAyQACAALwzISXAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4AQHACkSBTjB+AAAALNJREFUOMvVk70NAjEMhb87WYiGBZAQU7ABNSVSWpZgEEagsJDoKBELUCEKFuBuCKTw0xyQC0lICe5i+/k9/wT+3opUUJQhcAUqa8I5ZQT4tANwioGTCkQZA9vmOQE2oUJFhL0DXBz33RpKUfCLfLTQJMx9IlEWuQr6QB3prGtNS1lwiMvEYo7ekNsKRBkB+y+rH1hDFVOwy7ids+gbVzrsM6CXeYDTF85xroB1ZoHb73ymB5RhJkpZTihGAAAAAElFTkSuQmCC"
IMAGE_DOWN = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QABACnAADQ9FZaAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4AQHACQ1FZwK3gAAAMRJREFUOMvNkjEKAjEQRZ+jKNjYKh5AbzCdjVcQj+BFPIKlp7EMeAJrUbASQVCEr80uG9cNbqe/Cgn/5WUI/DqNfBHM+kCzbs+lPUAr2pwBq5qABbB+M8gszkDvS/kOdAG5VBgEM4ApsP0CGLukjxlEoA0wSZR3Lo0qhxhZDIBDAmDA0wsBLD51CZeOwLKivHbprZx6AkAHuEXbD5fawYwywMqAzOKeDTTPvKqcTGZBMLsGs0utn5gADYEHcKp9e9ni//MCDtNCE3qjsIwAAAAASUVORK5CYII="

def format_with_separator(value)
  value.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
end

puts "STEEM: $%f | image=%s" % [json["price_usd"], json["percent_change_1h"].to_f > 0 ? IMAGE_UP : IMAGE_DOWN]
puts "---"
puts "24h Volume: $%s" % [format_with_separator(json["24h_volume_usd"].to_i)]
puts "Market Cap: $%s" % [format_with_separator(json["market_cap_usd"].to_i)]
puts "---"
puts "1h Change: %s%" % [json["percent_change_1h"]]
puts "24h Change: %s%" % [json["percent_change_24h"]]
puts "7d Change: %s%" % [json["percent_change_7d"]]
