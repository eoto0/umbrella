# Write your soltuion here!

require "http"
require "json"
require "dotenv/load"

gmaps_api_key =  ENV.fetch("GMAPS_KEY")
pirate_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

pp "Where are you located?"

user_location = gets.chomp

#user_location = "Chicago"

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + gmaps_api_key


resp = HTTP.get(gmaps_url)

raw_response = resp.to_s

require "json"

parsed_response = JSON.parse(raw_response)

results = parsed_response.fetch("results")

#pp results

first_results = results.at(0)

pp first_results.keys

geometry = first_results.fetch("geometry") 

pp geometry.keys

location = geometry.fetch("location")


lat = location.fetch("lat")
lng = location.fetch("lng")

# pp lat
# pp lng

pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_api_key + "/" + lat.to_s + "," + lng.to_s

#pp pirate_weather_url


raw_response = HTTP.get(pirate_weather_url)

#pp raw_response


parsed_response = JSON.parse(raw_response)

temperature = parsed_response.fetch("currently").fetch("temperature")

summary = parsed_response.fetch("currently").fetch("summary")

pp temperature

pp summary



#pp parsed_response
