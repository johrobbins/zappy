//
//  Created by Joh Robbins on 6/9/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet var contentStackView: UIStackView!
    
    var location: Location?
    var forecastPeriod: ForecastPeriod?

    let userPreferences = UserPreferences()
    let weatherService = APIService()

    private static var star = UIImage(systemName: "star")
    private static var starFill = UIImage(systemName: "star.fill")

    static func createInstance(location: Location, forecastPeriod: ForecastPeriod) -> WeatherViewController {
        let currentWeatherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        currentWeatherViewController.configure(location: location, forecastPeriod: forecastPeriod)
        return currentWeatherViewController
    }

    private init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let location = location else { return print("No Location defined") }

        weatherService.getWeather(for: location) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):

//                    switch forecastPeriod {
//                    case .current:
//                    case .twentyFourHour:
//                    case .sevenDay:
//                    }

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

    func configure(location: Location, forecastPeriod: ForecastPeriod) {
        self.location = location
        self.forecastPeriod = forecastPeriod

        navigationItem.title = location.city
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        resetNavigationBar()
    }

    private func setupNavigationBar() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.barTintColor = UIColor(named: "primary")
        navigationBar.tintColor = UIColor(named: "text-white-secondary")
        navigationBar.isTranslucent = true
        navigationBar.barStyle = UIBarStyle.black // Set system icons to white

        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "text-white") ?? .white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 28) ?? UIFont.systemFont(ofSize: 28)
        ]

        let forecastSelectorBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(forecastSelectorButtonTapped))
        navigationItem.leftBarButtonItem = forecastSelectorBarButtonItem

        let favouriteIcon = isFavourite() ? WeatherViewController.starFill : WeatherViewController.star
        let favouriteBarButtonItem = UIBarButtonItem.init(image: favouriteIcon, style: .plain, target: self, action: #selector(favouriteButtonTapped))
        navigationItem.rightBarButtonItem = favouriteBarButtonItem
    }

    private func resetNavigationBar() {
        guard let navigationBar = self.navigationController?.navigationBar else { return print("No navigationController defined") }
        navigationBar.barTintColor = nil
        navigationBar.tintColor = nil
        navigationBar.isTranslucent = false
        navigationBar.barStyle = UIBarStyle.default
        navigationBar.titleTextAttributes = nil
    }
    
    func isFavourite() -> Bool {
        guard let favourite = userPreferences.loadFavourite() else { return false }
        return favourite.location == location && favourite.forecastPeriod == forecastPeriod ? true : false
    }

    func updateFavouriteButton() {
        let favouriteIcon = isFavourite() ? WeatherViewController.starFill : WeatherViewController.star
        navigationItem.rightBarButtonItem?.image = favouriteIcon
    }

    @objc func forecastSelectorButtonTapped() {
        guard let navigation = navigationController, let location = location else { return print("No navigationController defined") }

        navigation.popViewController(animated: true)

        let forecastSelectorViewController =  navigation.topViewController as! ForecastSelectorViewController
        forecastSelectorViewController.configure(location: location)
    }

    @objc func favouriteButtonTapped() {
        if isFavourite() {
            userPreferences.removeFavourite()
        } else {
            guard let location = location, let forecastPeriod = forecastPeriod else { return print("No Location and/or ForecastPeriod defined") }
            let favourite = Favourite(location: location, forecastPeriod: forecastPeriod)
            userPreferences.saveFavourite(with: favourite)
        }

        updateFavouriteButton()
    }
}
