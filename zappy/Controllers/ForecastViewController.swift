//
//  Created by Joh Robbins on 21/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
  @IBOutlet private var cityLabel: UILabel!

  var forecast: Forecast?
  var location: Location?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  private func setupUI() {
    navigationItem.title = forecast?.rawValue
    guard let location = location else { return }
    cityLabel.text = location.city
  }
}
