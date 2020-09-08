//
//  Created by Joh Robbins on 6/9/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class BaseWeatherViewController: UIViewController {
    var location: Location!
    var forecastPeriod: ForecastPeriod!

    let userPreferences = UserPreferences()
    let weatherService = APIService()

    private var isFavourited = false;
    private static var star = UIImage(systemName: "star")
    private static var starFill = UIImage(systemName: "star.fill")

    private init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configure(location: Location, forecastPeriod: ForecastPeriod) {
        self.location = location
        self.forecastPeriod = forecastPeriod
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        isFavouriteView()
        setupNavigationBarItems()
    }

    func setupNavigationBarItems() {
        let forecastSelectorBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(navigateToForecastSelector))
        navigationItem.leftBarButtonItem = forecastSelectorBarButtonItem

        let favouriteIcon = isFavourited ? BaseWeatherViewController.starFill : BaseWeatherViewController.star
        let favouriteBarButtonItem = UIBarButtonItem.init(image: favouriteIcon, style: .plain, target: self, action: #selector(toggleFavourite))
        navigationItem.rightBarButtonItem = favouriteBarButtonItem
    }
    
    func isFavouriteView() {
        if let favourite = userPreferences.loadFavourite() {
            isFavourited = favourite.location == location && favourite.forecastPeriod == forecastPeriod ? true : false
        }
    }

    @objc func navigateToForecastSelector() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)

            let forecastSelectorViewController =  navigationController.topViewController as! ForecastSelectorViewController
            forecastSelectorViewController.configure(location: location)
        }
    }

    @objc func toggleFavourite() {
        isFavourited.toggle()

        if isFavourited {
            navigationItem.rightBarButtonItem?.image = BaseWeatherViewController.starFill
            guard let location = location, let forecastPeriod = forecastPeriod else { return }
            let favourite = Favourite(location: location, forecastPeriod: forecastPeriod)
            userPreferences.saveFavourite(with: favourite)
        } else {
            navigationItem.rightBarButtonItem?.image = BaseWeatherViewController.star
            userPreferences.removeFavourite()
        }
    }
}
