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

#pp geometry.keys

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

#pp temperature

#pp summary

data = parsed_response.fetch("hourly").fetch("data")


require "time"

#time = Time.at(data[0]["time"])

#pp time

first_time = Time.at(data.first["time"])

pp first_time

next_12_hours = data.first(12)


rainy_hours = next_12_hours.select {|hour| hour["precipProbability"] > 0.1 }

if rainy_hours.any?
  pp "You might want to carry an umbrella"

rainy_hours.each do |hour|
  time = Time.at(hour["time"])
  hours_later = (time - first_time)/3600.round
  chance = (hour["precipProbability"]*100).round
  pp hours_later
  pp "#{chance}% chance of rain #{hours_later} hours later than the forecasted hour"
end

else 
  pp "You probably won't need an umbrella today"
end



# data.first(12).each do |hour|
#   pp time = Time.at(hour["time"])
#   pp time
#   if hour["precipProbability"] > 0.1 
#     pp "You might want to carry an umbrella"
#     hours_later = (time - first_time) 
#     pp "This is {#hours_later} hours later than the forecasted hour"
#   else 
#     pp "You probably won't need an umbrella today"
#   end
# end
#pp parsed_response
