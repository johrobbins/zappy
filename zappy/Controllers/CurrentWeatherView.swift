//
//  Created by Joh Robbins on 30/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var currentTempatureLabel: UILabel!

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
    contentView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(contentView)
    contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
  }

  func configure(temp: String) {
    currentTempatureLabel.text = temp
  }
}
