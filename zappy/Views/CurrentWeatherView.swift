//
//  Created by Joh Robbins on 30/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {
    @IBOutlet private var summaryLabel: UILabel!
    @IBOutlet private var currentTempatureLabel: UILabel!
    @IBOutlet private var feelsLikeTempatureLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var windDirectionLabel: UILabel!

    private var numberFormatter = NumberFormatter() {
        didSet {
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 2
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ currentWeather: Current) {
        summaryLabel.text = currentWeather.summary
        currentTempatureLabel.text = "\(formatTempaturetoString(with: currentWeather.temperature))°"
        feelsLikeTempatureLabel.text = "Feels like \(formatTempaturetoString(with: currentWeather.apparentTemperature))°"
        iconImageView.image = UIImage(named: currentWeather.icon) ?? UIImage(named: "icon-placeholder")
        windDirectionLabel.text =  WindDirection().convertToDisplayString(windSpeed: currentWeather.windSpeed, windBearing: currentWeather.windBearing)
    }

    private func formatTempaturetoString(with tempature: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1

        return numberFormatter.string(from: NSNumber(value: tempature)) ?? "-999"
    }
}
