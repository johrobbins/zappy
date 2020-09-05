//
//  Created by Joh Robbins on 21/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class ForecastSelectorViewController: UITableViewController {
    var location: Location?

    // MARK: - Table View Functions

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "ShowCurrentWeather", sender: ForecastPeriod.current)
        case 1:
            performSegue(withIdentifier: "ShowTwentyFourHourWeather", sender: ForecastPeriod.twentyFourHour)
        case 2:
            performSegue(withIdentifier: "ShowSevenDayWeather", sender: ForecastPeriod.sevenDay)
        default:
            return
        }
    }

    // MARK: - Segue Handler

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCurrentWeather" {
            let currentWeatherViewController = segue.destination as! CurrentWeatherViewController
            currentWeatherViewController.forecastPeriod = ForecastPeriod.current
            currentWeatherViewController.location = location
        } else if segue.identifier == "ShowTwentyFourHourWeather"  {
            let currentWeatherViewController = segue.destination as! TwentyFourHourWeatherViewController
            currentWeatherViewController.forecastPeriod = ForecastPeriod.twentyFourHour
            currentWeatherViewController.location = location
        } else if segue.identifier == "ShowSevenDayWeather"  {
            let currentWeatherViewController = segue.destination as! SevenDayWeatherViewController
            currentWeatherViewController.forecastPeriod = ForecastPeriod.sevenDay
            currentWeatherViewController.location = location
        }
    }
}
