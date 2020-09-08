//
//  Created by Joh Robbins on 5/9/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class TwentyFourHourWeatherViewController: BaseWeatherViewController {
    static func createInstance(location: Location, forecastPeriod: ForecastPeriod) -> TwentyFourHourWeatherViewController {
        let twentyFourHourWeatherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TwentyFourHourWeatherViewController") as! TwentyFourHourWeatherViewController
        twentyFourHourWeatherViewController.configure(location: location, forecastPeriod: forecastPeriod)
        return twentyFourHourWeatherViewController
    }
}
