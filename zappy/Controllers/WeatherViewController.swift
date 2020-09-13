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

    func configure(location: Location, forecastPeriod: ForecastPeriod) {
        self.location = location
        self.forecastPeriod = forecastPeriod

        navigationItem.title = location.city

        createWeatherViews(location: location, forecastPeriod: forecastPeriod)
    }

    private func createWeatherViews(location: Location, forecastPeriod: ForecastPeriod) {
        weatherService.getWeather(for: location) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    let weatherViews = self.createWeatherViews(forecastPeriod: forecastPeriod, weather: weather)
                    weatherViews.forEach(self.contentStackView.addArrangedSubview)
                    //self.view.backgroundColor = UIColor(named: "primary")

                case .failure(let error):
                    let retryAction = { self.createWeatherViews(location: location, forecastPeriod: forecastPeriod) }

                    let errorView = ErrorView()
                    errorView.configure(error: error, action: retryAction)
                    self.contentStackView.addArrangedSubview(errorView)
                    self.contentStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                }
            }
        }
    }

    private func createWeatherViews(forecastPeriod: ForecastPeriod, weather: Weather) -> [UIView] {
        var weatherViews: [UIView] = []

        switch forecastPeriod {
        case .current:
            view.backgroundColor = UIColor(named: "primary")
            weatherViews.append(createCurrentWeatherView(weather.currently))
        case .twentyFourHour:
            view.backgroundColor = UIColor(named: "primary")
            weatherViews.append(createTwentyFourHourWeatherView(weather.daily.data[0]))
        case .sevenDay:
            weatherViews.append(createSevenDayWeatherView(weather))
            contentStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        case .allInOne:
            weatherViews.append(createCurrentWeatherView(weather.currently))
            weatherViews.append(createTwentyFourHourWeatherView(weather.daily.data[0]))
            weatherViews.append(createSevenDayWeatherView(weather))
            contentStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }

        return weatherViews
    }

    private func createCurrentWeatherView(_ currentWeather: Current) -> UIView {
        let currentWeatherView = CurrentWeatherView()
        currentWeatherView.configure(currentWeather)
        return currentWeatherView
    }

    private func createTwentyFourHourWeatherView(_ currentDay: CurrentDay) -> UIView {
        let twentyFourHourWeatherView = TwentyFourHourWeatherView()
        twentyFourHourWeatherView.configure(currentDay)
        return twentyFourHourWeatherView
    }

    private func createSevenDayWeatherView(_ weather: Weather) -> UIView {
        let sevenDayWeatherView = SevenDayWeatherView()
        sevenDayWeatherView.configure(weather)
        return sevenDayWeatherView
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

        let favouriteBarButtonItem = UIBarButtonItem.init(image: nil, style: .plain, target: self, action: #selector(favouriteButtonTapped))
        navigationItem.rightBarButtonItem = favouriteBarButtonItem
        updateFavouriteButton()
    }

    private func resetNavigationBar() {
        guard let navigationBar = self.navigationController?.navigationBar else { return print("No navigationController defined") }
        navigationBar.barTintColor = nil
        navigationBar.tintColor = nil
        navigationBar.isTranslucent = false
        navigationBar.barStyle = UIBarStyle.default
        navigationBar.titleTextAttributes = nil
    }
    
    func isFavouriteView() -> Bool {
        guard let favourite = userPreferences.loadFavourite() else { return false }
        return favourite.location == location && favourite.forecastPeriod == forecastPeriod ? true : false
    }

    func updateFavouriteButton() {
        let isFavourite = isFavouriteView()
        let favouriteIcon = isFavourite ? WeatherViewController.starFill : WeatherViewController.star
        navigationItem.rightBarButtonItem?.image = favouriteIcon

        let iconTint = isFavourite ? UIColor(named: "favouriteIcon-yellow") : UIColor(named: "text-white-secondary")
        navigationItem.rightBarButtonItem?.tintColor = iconTint
    }

    @objc func forecastSelectorButtonTapped() {
        guard let navigation = navigationController, let location = location else { return print("No navigationController defined") }

        navigation.popViewController(animated: true)

        let forecastSelectorViewController =  navigation.topViewController as! ForecastSelectorViewController
        forecastSelectorViewController.configure(location: location)
    }

    @objc func favouriteButtonTapped() {
        if isFavouriteView() {
            userPreferences.removeFavourite()
        } else {
            guard let location = location, let forecastPeriod = forecastPeriod else { return print("No Location and/or ForecastPeriod defined") }
            let favourite = Favourite(location: location, forecastPeriod: forecastPeriod)
            userPreferences.saveFavourite(with: favourite)
        }

        updateFavouriteButton()
    }
}
