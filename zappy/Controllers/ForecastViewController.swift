//
//  Created by Joh Robbins on 21/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
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
    if isFavourited {
      sender.image = UIImage(systemName: "star.fill")
      guard let location = location, let forecast = forecast else { return }
      let favourite = Favourite(location: location, forecast: forecast)
      userPreferences.saveFavourite(with: favourite)
    } else {
      sender.image = UIImage(systemName: "star")
      userPreferences.removeFavourite()
    }
  }

  private func setupUI() {
    navigationItem.title = forecast?.rawValue
    guard let location = location else { return }
    cityLabel.text = location.city
  }
}
