//
//  Created by Joh Robbins on 29/8/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    @IBOutlet private var weatherIconImageView: UIImageView!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var tempatureLabel: UILabel!
    @IBOutlet var windDirectionLabel: UILabel!

    func configure(currentDay: CurrentDay, timezone: String) {
        weatherIconImageView.image = UIImage(named: currentDay.icon)
        dayLabel.text = "Monday"
        descriptionLabel.text = currentDay.summary

        let tempatureMin = Int(currentDay.temperatureMin)
        let tempatureMax = Int(currentDay.temperatureMax)
        tempatureLabel.text = "\(tempatureMin)°C - \(tempatureMax)°C"

        let date = Date(timeIntervalSince1970: currentDay.time)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEEE" //Specify your format that you want
        dayLabel.text = dateFormatter.string(from: date)
    }
}
