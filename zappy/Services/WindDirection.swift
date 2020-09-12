//
//  Created by Joh Robbins on 10/9/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

class WindDirection {
    private static let compassDirections = ["N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]

    func convertToDisplayString(windSpeed: Double, windBearing: Int) -> String {
        // If windSpeed is zero, then Wind Bearing value will not be defined
        let windCompassDirection = windSpeed == 0 ? "" : convertToCompassDirection(degree: windBearing)
        return "\(Int(windSpeed)) km/h \(windCompassDirection)"
    }

    private func convertToCompassDirection(degree: Int) -> String {
        let index = Int((Double(degree) + 11.25).truncatingRemainder(dividingBy: 360) / 22.5)
        return WindDirection.compassDirections[index]
    }
}
