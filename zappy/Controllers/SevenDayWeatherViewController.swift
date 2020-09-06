//
//  Created by Joh Robbins on 5/9/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class SevenDayWeatherViewController: WeatherViewController {
    static func createInstance(location: Location, forecastPeriod: ForecastPeriod) -> SevenDayWeatherViewController {
        let sevenDayWeatherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SevenDayWeatherViewController") as! SevenDayWeatherViewController
        sevenDayWeatherViewController.configure(location: location, forecastPeriod: forecastPeriod)
        return sevenDayWeatherViewController
    }
}
