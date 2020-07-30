//
//  Created by Joh Robbins on 30/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

struct WeatherReport {
  var currentTempature: Float
  var forecasts: [Forecast]
}

extension WeatherReport {
  static func loadExampleWeatherReport() -> WeatherReport {
    return WeatherReport(
      currentTempature: 26.7,
      forecasts: [
        Forecast(
          //date: Date(),
          summary: "Sunny",
          icon: "sun.max",
          maximumTemperature: 28,
          minimumTemperature: 18,
          windDirection: 270,
          windSpeed: 15),
        Forecast(
          //date: Date(),
          summary: "Cloudy",
          icon: "sun.max",
          maximumTemperature: 20,
          minimumTemperature: 16,
          windDirection: 270,
          windSpeed: 5),
        Forecast(
          //date: Date(),
          summary: "Sunny",
          icon: "sun.max",
          maximumTemperature: 29,
          minimumTemperature: 20,
          windDirection: 42,
          windSpeed: 10)
      ])
  }
}
