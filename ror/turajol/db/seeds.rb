points = [
              ['42.8767446','74.6069949'], ['42.876404','74.610697'],
              ['42.874958','74.613304'],['42.877647', '74.607275'],
              ['42.87793','74.612757'], ['42.876184','74.614592']
          ]

points.each do |point|
  latitude, longitude = point
  @point = Point.create(latitude: latitude, longitude: longitude)
end