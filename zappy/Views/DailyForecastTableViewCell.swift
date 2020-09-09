//
//  Created by Joh Robbins on 29/8/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    @IBOutlet private var weatherIconImageView: UIImageView!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var tempatureLabel: UILabel!
    @IBOutlet private var windDirectionLabel: UILabel!

    func configure(currentDay: CurrentDay, timezone: String) {
        weatherIconImageView.image = UIImage(named: currentDay.icon)
        dateLabel.text = "Monday"
        descriptionLabel.text = currentDay.summary

        let tempatureMin = Int(currentDay.temperatureMin)
        let tempatureMax = Int(currentDay.temperatureMax)
        tempatureLabel.text = "\(tempatureMin)°C - \(tempatureMax)°C"

        let date = Date(timeIntervalSince1970: currentDay.time)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEEE" //Specify your format that you want
        dateLabel.text = dateFormatter.string(from: date)
    }
}
