//
//  Created by Joh Robbins on 21/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class ForecastListTableViewController: UITableViewController {
  var location: Location?

  // MARK: - Table View Functions

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let forecast: Forecast

    switch indexPath.row {
      case 0:
        forecast = Forecast.current
      case 1:
        forecast = Forecast.twentyFourHour
      case 2:
        forecast = Forecast.sevenDay
    default:
      return
    }
    performSegue(withIdentifier: "ShowForecast", sender: forecast)
  }

  // MARK: - Segue Handler

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowForecast",
    let forecastViewController = segue.destination as? ForecastViewController {
      let forecast = sender as! Forecast
      forecastViewController.forecast = forecast
      forecastViewController.location = location
    }
  }
}
