//
//  Created by Joh Robbins on 26/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

enum ForecastPeriod: String, Codable {
    case current = "Current weather"
    case twentyFourHour = "24-hour forecast"
    case sevenDay = "7-day forecast"
    case allInOne = "All in one"
}
