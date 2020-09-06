//
//  Created by Joh Robbins on 6/9/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

extension UIViewController {
    func returnToForecastSelector(for location: Location) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)

            let forecastSelectorViewController =  navigationController.topViewController as! ForecastSelectorViewController
            forecastSelectorViewController.configure(location: location)
        }
    }
}
