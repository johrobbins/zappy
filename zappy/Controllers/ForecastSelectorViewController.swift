//
//  Created by Joh Robbins on 21/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class ForecastSelectorViewController: UITableViewController {
  var location: Location?

  // MARK: - Table View Functions

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let forecastPeriod: ForecastPeriod

    switch indexPath.row {
      case 0:
        forecastPeriod = ForecastPeriod.current
      case 1:
        forecastPeriod = ForecastPeriod.twentyFourHour
      case 2:
        forecastPeriod = ForecastPeriod.sevenDay
    default:
      return
    }
    performSegue(withIdentifier: "ShowForecast", sender: forecastPeriod)
  }

  // MARK: - Segue Handler

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowForecast",
    let forecastViewController = segue.destination as? WeatherViewController {
      let forecastPeriod = sender as! ForecastPeriod
      forecastViewController.forecastPeriod = forecastPeriod
      forecastViewController.location = location
    }

    if segue.identifier == "ShowForecast",
    let navigationController = segue.destination as? UINavigationController,
    let forecastViewController = navigationController.topViewController as? WeatherViewController {
      let forecastPeriod = sender as! ForecastPeriod
      forecastViewController.forecastPeriod = forecastPeriod
      forecastViewController.location = location
    }
  }
}
