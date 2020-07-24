//
//  Created by Joh Robbins on 21/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class ForecastListTableViewController: UITableViewController {
  var location: Location?

  // MARK: - Table View Functions

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    performSegue(withIdentifier: "ShowForecast", sender: cell?.textLabel?.text)
  }

  // MARK: - Segue Handler

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowForecast",
    let forecastViewController = segue.destination as? ForecastViewController {
      let title = sender as! String
      forecastViewController.screenTitle = title
      forecastViewController.location = location
    }
  }
}
