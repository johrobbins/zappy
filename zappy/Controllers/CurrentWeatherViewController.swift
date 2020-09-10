//
//  Created by Joh Robbins on 21/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: BaseWeatherViewController {
    @IBOutlet private var contentStackView: UIStackView!

    static func createInstance(location: Location, forecastPeriod: ForecastPeriod) -> CurrentWeatherViewController {
        let currentWeatherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentWeatherViewController") as! CurrentWeatherViewController
        currentWeatherViewController.configure(location: location, forecastPeriod: forecastPeriod)
        return currentWeatherViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let location = location else { return print("No Location defined") }

        weatherService.getWeather(for: location) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    let currentWeatherView = CurrentWeatherView()
                    currentWeatherView.configure(weather.currently)

                    let sevenDayWeatherView = SevenDayWeatherView()
                    sevenDayWeatherView.configure(weather)

                    self.contentStackView.addArrangedSubview(currentWeatherView)
                    self.contentStackView.addArrangedSubview(sevenDayWeatherView)

                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
