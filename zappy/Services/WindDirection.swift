//
//  Created by Joh Robbins on 10/9/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

class WindDirection {
    private static let compassDirections = ["N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
    func convertToCompassDirection(degree: Int) -> String {
        let index = Int((Double(degree) + 11.25).truncatingRemainder(dividingBy: 360) / 22.5)
        return WindDirection.compassDirections[index]
    }
}
