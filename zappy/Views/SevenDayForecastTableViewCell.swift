//
//  Created by Joh Robbins on 29/8/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class SevenDayForecastTableViewCell: UITableViewCell {
    @IBOutlet private var DayLabel: UILabel!
    @IBOutlet private var DescriptionLabel: UILabel!
    @IBOutlet private var TempatureLabel: UILabel!
    @IBOutlet private var WindDirectionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func Configure() {
        
    }
}
