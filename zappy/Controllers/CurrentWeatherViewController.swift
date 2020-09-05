//
//  Created by Joh Robbins on 21/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: UIViewController {
    @IBOutlet private var favouriteBarButtonItem: UIBarButtonItem!
    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var contentStackView: UIStackView!

    var forecastPeriod: ForecastPeriod?
    var location: Location!
    var isFavourited = false;

    private let userPreferences = UserPreferences()
    private let weatherService = APIService()

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

