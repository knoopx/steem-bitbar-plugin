#!/usr/bin/env ruby
# <bitbar.title>STEEM WALLET</bitbar.title>
# <bitbar.version>1.0</bitbar.version>
# <bitbar.author>Víctor Martínez</bitbar.author>
# <bitbar.author.github>knoopx</bitbar.author.github>
# <bitbar.desc>Steem wallet</bitbar.desc>
# <bitbar.dependencies>ruby</bitbar.dependencies>
# <bitbar.abouturl>http://knoopx.net/</bitbar.abouturl>

USERNAME = ENV.fetch("USER")
ICON = "iVBORw0KGgoAAAANSUhEUgAAABMAAAATCAQAAADYWf5HAAABN0lEQVQYGQXBvyvmcRwA8BfPw6P8SMp9U093z3kWKZsFy/MvXBYL0k1XtituUTqzYjAoAyabzeB3BiWDDMpgsOCWu2e4Dl89Pu97vQAAekwCAAAA0OSLGwAAALqMgapHdQDt+hUA6HXiOwp+CXUACxYVATJLct/QJ4QXwITcggLAiFNhFe1CeDcFroQ1JYCKXcmdNlwKIRRxKPmtDNDqh9yrWQx6F8IMxrwJiwAMu5ccK2uxI4R9HbiW/FEBYE/I1TAjhDCNmoawCsCQN8k+MmdC2NKi4lxyqwrAhvAXzAuhoYI5uX++AjAgJD/RJoQwi8yTZEUJoMuRZ6NgXRKewblX8woA3c4sA5o0hE1w4cBHAD7b1gOg4UGGzJEyAHToBvBJ3Tj4oBMAAIAD04oAAAAAVDUDAPwHvP5sKRhf0KEAAAAASUVORK5CYII="

require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(open("https://steemit.com/@#{USERNAME}/transfers").read)


steems = doc.at(".App__content .row:nth-child(2) .small-3").inner_text
steem_power = doc.at(".App__content .row:nth-child(3) .small-3").inner_text
steem_dollars = doc.at(".App__content .row:nth-child(4) .small-3").inner_text
estimated_value = doc.at(".App__content .row:nth-child(5) .small-3").inner_text

puts "%s | image=#{ICON}" % [estimated_value]
puts "---"
puts "Balance"
puts "-- %s" % steems
puts "-- %s POWER" % steem_power
puts "-- %s STEEM DOLLARS" % steem_dollars

puts "History"
doc.search(".App__content .row:nth-child(8) table tr").each do |row|
  date, text = row.search("td").map(&:inner_text)
  puts "-- %s | size=14" % text
  puts "-- %s" % date
  puts "-----"
end

puts "Posts"
doc = Nokogiri::HTML(open("https://steemit.com/@#{USERNAME}/posts").read)
doc.search(".hentry").each do |row|
  puts "-- %s | size=14 href=%s" % [row.at(".entry-title").inner_text, "https://steemit.com#{row.at(".entry-title a")["href"]}"]
  puts "-- %s" % row.at(".FormattedAsset").inner_text
  puts "-----"
end
