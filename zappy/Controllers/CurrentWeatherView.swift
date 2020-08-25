//
//  Created by Joh Robbins on 30/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {
  @IBOutlet private var contentView: UIView!
  @IBOutlet private var summaryLabel: UILabel!
  @IBOutlet private var currentTempatureLabel: UILabel!
  @IBOutlet private var feelsLikeTempatureLabel: UILabel!
  @IBOutlet private var iconImageView: UIImageView!

  override init(frame: CGRect) {
  super.init(frame: frame)
    loadViewFromNib()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    loadViewFromNib()
  }

  func loadViewFromNib() {
    Bundle.main.loadNibNamed("CurrentWeatherView", owner: self, options: nil)
    addSubview(contentView)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
  }

  func configure(_ currentWeather: CurrentWeather) {
    summaryLabel.text = currentWeather.summary
    currentTempatureLabel.text = String(format: "%.1f", currentWeather.temperature)
    feelsLikeTempatureLabel.text = String(format: "Feels like %.1f", currentWeather.apparentTemperature)
    iconImageView.image = UIImage(named: currentWeather.icon)
  }
}
