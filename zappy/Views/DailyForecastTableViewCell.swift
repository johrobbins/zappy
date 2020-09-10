//
//  Created by Joh Robbins on 29/8/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    @IBOutlet private var weatherIconImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var tempatureLabel: UILabel!
    @IBOutlet var windDirectionLabel: UILabel!

    func configure(currentDay: CurrentDay, timezone: String) {
        weatherIconImageView.image = UIImage(named: currentDay.icon)
        dateLabel.text = formatDate(time: currentDay.time, timezone: timezone)
        descriptionLabel.text = currentDay.summary
        tempatureLabel.attributedText = createStyledTempatureText(min: Int(currentDay.temperatureMin), max: Int(currentDay.temperatureMax))

        // If windSpeed is zero, then Wind Bearing value will not be defined
        let windCompassDirection = currentDay.windSpeed == 0 ? "" : WindDirection().convertToCompassDirection(degree: currentDay.windBearing)
        windDirectionLabel.text = "\(Int(currentDay.windSpeed)) km/h \(windCompassDirection)"
    }

    private func createStyledTempatureText(min: Int, max: Int) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(min)°", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])
        attributedString.append(NSMutableAttributedString(string:"  -  "))
        attributedString.append(NSMutableAttributedString(string: "\(max)°", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]))

        return attributedString
    }

    private func formatDate(time: Double, timezone: String) -> String {
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)

        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal

        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter.string(from: date)
    }
}
