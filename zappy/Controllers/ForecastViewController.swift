//
//  Created by Joh Robbins on 21/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
  @IBOutlet weak var favouriteBarButtonItem: UIBarButtonItem!
  @IBOutlet private var cityLabel: UILabel!

  var forecast: Forecast?
  var location: Location?
  var isFavourited = false;

  private let userPreferences = UserPreferences()


  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  @IBAction func toggleFavourite(_ sender: UIBarButtonItem) {
    isFavourited.toggle()
    animateFavouriteIcon(isFavourited)
    if isFavourited {
      guard let location = location, let forecast = forecast else { return }
      let favourite = Favourite(location: location, forecast: forecast)
      userPreferences.saveFavourite(with: favourite)
    } else {
      userPreferences.removeFavourite()
    }
  }

  private func setupUI() {
    navigationItem.title = forecast?.rawValue
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
