//
//  Created by Joh Robbins on 21/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: WeatherViewController {
    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var contentStackView: UIStackView!

    static func createInstance(location: Location, forecastPeriod: ForecastPeriod) -> CurrentWeatherViewController {
        let currentWeatherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentWeatherViewController") as! CurrentWeatherViewController
        currentWeatherViewController.configure(location: location, forecastPeriod: forecastPeriod)
        return currentWeatherViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        weatherService.getWeather(for: location) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    let currentWeatherView = CurrentWeatherView(frame: CGRect(x: 0, y: 0, width: self.contentStackView.frame.width, height: 200))
                    self.contentStackView.addSubview(currentWeatherView)
                    currentWeatherView.configure(weather.currently)

                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        returnToForecastSelector(for: location)
    }

    private func setupUI() {
        guard let location = location else { return }
        cityLabel.text = location.city
    }
}
