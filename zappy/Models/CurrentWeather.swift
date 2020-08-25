//
//  Created by Joh Robbins on 22/8/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

struct CurrentWeather: Decodable {
    var summary: String
    var icon: String
    var temperature: Float
    var apparentTemperature: Float
    var windBearing: Int
    var windSpeed: Float
}
