//
//  Created by Joh Robbins on 22/8/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

struct Weather: Decodable {
    var timezone: String
    var currently: Current
    var daily: Daily
}

struct Current: Decodable {
    var summary: String
    var icon: String
    var temperature: Double
    var apparentTemperature: Double
    var windBearing: Int
    var windSpeed: Double
}

struct Daily: Decodable {
    var data: [CurrentDay]
}

struct CurrentDay: Decodable {
    var time: Double
    var summary: String
    var icon: String
    var temperatureMax: Double
    var temperatureMin: Double
    var windBearing: Int
    var windSpeed: Double
}
