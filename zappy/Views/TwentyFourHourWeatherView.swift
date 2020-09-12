//
//  Created by Joh Robbins on 12/9/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class TwentyFourHourWeatherView: UIView  {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var weatherIconImageView: UIImageView!
    @IBOutlet private var tempatureLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var windDirectionLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadViewFromNib() {
        Bundle.main.loadNibNamed("TwentyFourHourWeatherView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    func configure(_ currentDay: CurrentDay) {
        weatherIconImageView.image = UIImage(named: currentDay.icon)
        descriptionLabel.text = currentDay.summary
        tempatureLabel.attributedText = createStyledTempatureText(min: Int(currentDay.temperatureMin), max: Int(currentDay.temperatureMax))
        windDirectionLabel.text =  WindDirection().convertToDisplayString(windSpeed: currentDay.windSpeed, windBearing: currentDay.windBearing)
    }

    private func createStyledTempatureText(min: Int, max: Int) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(min)°", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        attributedString.append(NSMutableAttributedString(string:"  -  "))
        attributedString.append(NSMutableAttributedString(string: "\(max)°", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]))

        return attributedString
    }
}
