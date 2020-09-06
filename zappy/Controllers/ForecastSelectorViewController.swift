//
//  Created by Joh Robbins on 21/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class ForecastSelectorViewController: UITableViewController {
    private var location: Location!

    func configure(location: Location) {
        self.location = location
    }

    // MARK: - Table View Functions

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "ShowCurrentWeather", sender: nil)
        case 1:
            performSegue(withIdentifier: "ShowTwentyFourHourWeather", sender: nil)
        case 2:
            performSegue(withIdentifier: "ShowSevenDayWeather", sender: nil)
        default:
            return
        }
    }

    // MARK: - Segue Handler

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCurrentWeather" {
            let currentWeatherViewController = segue.destination as! CurrentWeatherViewController
            currentWeatherViewController.configure(location: location, forecastPeriod: ForecastPeriod.current)
        } else if segue.identifier == "ShowTwentyFourHourWeather"  {
            let twentyFourHourWeatherViewController = segue.destination as! TwentyFourHourWeatherViewController
            twentyFourHourWeatherViewController.configure(location: location, forecastPeriod: ForecastPeriod.twentyFourHour)
        } else if segue.identifier == "ShowSevenDayWeather"  {
            let sevenDayWeatherViewController = segue.destination as! SevenDayWeatherViewController
            sevenDayWeatherViewController.configure(location: location, forecastPeriod: ForecastPeriod.sevenDay)
        }
    }
}
