//
//  Created by Joh Robbins on 21/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
  @IBOutlet private var favouriteBarButtonItem: UIBarButtonItem!
  @IBOutlet private var cityLabel: UILabel!

  @IBOutlet private var weatherView: CurrentWeatherView!

  var forecastPeriod: ForecastPeriod?
  var location: Location!
  var isFavourited = false;
    
  private let userPreferences = UserPreferences()
    private let weatherService = APIService()
    private var weather: Weather?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    weatherView.configure(temp: "18")

    weatherService.getWeather(for: location) { result in
        DispatchQueue.main.async {
            //self.weather = weather
            //self.updateUI()
            switch result {
            case .success(let weather):
                self.weather = weather
                print(weather)
            case .failure(let error):
                print(error)
            }
        }
    }
  }

  @IBAction func toggleFavourite(_ sender: UIBarButtonItem) {
    isFavourited.toggle()
    animateFavouriteIcon(isFavourited)
    if isFavourited {
      guard let location = location, let forecastPeriod = forecastPeriod else { return }
      let favourite = Favourite(location: location, forecastPeriod: forecastPeriod)
      userPreferences.saveFavourite(with: favourite)
    } else {
      userPreferences.removeFavourite()
    }
  }

  private func setupUI() {
    navigationItem.title = forecastPeriod?.rawValue
    animateFavouriteIcon(isFavourited)

    guard let location = location else { return }
    cityLabel.text = location.city
  }

  private func animateFavouriteIcon(_ fill: Bool) {
    if fill {
      favouriteBarButtonItem.image = UIImage(systemName: "star.fill")
    } else {
      favouriteBarButtonItem.image = UIImage(systemName: "star")
    }
  }
}
