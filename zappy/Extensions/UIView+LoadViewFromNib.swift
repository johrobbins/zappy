//
//  Created by Joh Robbins on 13/9/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

extension UIView {
    func loadViewFromNib() {
        let nib = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        if let view = nib?.first as? UIView {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
    }
}
