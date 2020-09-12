//
//  Created by Joh Robbins on 21/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class ForecastSelectorViewController: UITableViewController {
    private var location: Location?

    func configure(location: Location) {
        self.location = location
    }

    // MARK: - Table View Functions

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "ShowWeather", sender: ForecastPeriod.current)
        case 1:
            performSegue(withIdentifier: "ShowWeather", sender: ForecastPeriod.twentyFourHour)
        case 2:
            performSegue(withIdentifier: "ShowWeather", sender: ForecastPeriod.sevenDay)
        case 3:
            performSegue(withIdentifier: "ShowWeather", sender: ForecastPeriod.allInOne)
        default:
            return
        }
    }

    // MARK: - Segue Handler

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let location = location else { return print("No location defined") }
        
        if segue.identifier == "ShowWeather" {
            let weatherViewController = segue.destination as? WeatherViewController
            weatherViewController?.configure(location: location, forecastPeriod: sender as! ForecastPeriod)
        }
    }
}
