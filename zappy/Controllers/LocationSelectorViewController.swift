//
//  Created by Joh Robbins on 21/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class LocationSelectorViewController: UITableViewController {
  private var locations = [Location]()

  override func viewDidLoad() {
    super.viewDidLoad()

    locations = Location.loadLocations()
  }

  // MARK: - Table View Functions

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return locations.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
    let location = locations[indexPath.row]

    cell.textLabel?.text = "\(location.city), \(location.state)"

    return cell
  }

  // MARK: - Segue Handler

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "SelectForecast",
    let forecastSelectorViewController = segue.destination as? ForecastSelectorViewController {
      let indexPath = tableView.indexPathForSelectedRow!
      let location = locations[indexPath.row]
      forecastSelectorViewController.location = location
    }
  }
}
