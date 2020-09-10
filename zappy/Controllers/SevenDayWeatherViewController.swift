//
//  Created by Joh Robbins on 5/9/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class SevenDayWeatherViewController: BaseWeatherViewController, UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet private var tableView: UITableView!

    private var weather: Weather?

    static func createInstance(location: Location, forecastPeriod: ForecastPeriod) -> SevenDayWeatherViewController {
        let sevenDayWeatherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SevenDayWeatherViewController") as! SevenDayWeatherViewController
        sevenDayWeatherViewController.configure(location: location, forecastPeriod: forecastPeriod)
        return sevenDayWeatherViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let location = location else { return print("No Location defined") }

        tableView.delegate = self
        tableView.dataSource = self

        weatherService.getWeather(for: location) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.weather = weather
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather?.daily.data.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyForecastCell", for: indexPath)// as! DailyForecastTableViewCell

//        if let currentDay = weather?.daily.data, let timezone = weather?.timezone {
//            cell.configure(currentDay: currentDay[indexPath.row], timezone: timezone)
//            return cell
//        }

        return cell
    }
}
