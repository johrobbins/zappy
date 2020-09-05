//
//  Created by Joh Robbins on 30/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class SevenDayForecastTableView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet var tableView: UITableView!

    let test: [Int] = [1, 2, 3]

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }

    func loadViewFromNib() {
        Bundle.main.loadNibNamed("SevenDayForecastTableView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    func configure() {
        tableView.register(SevenDayForecastTableViewCell.self, forCellReuseIdentifier: "SevenDayForecastCell")
    }
}

extension SevenDayForecastTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SevenDayForecastCell", for: indexPath)// as! SevenDayForecastTableViewCell
        return cell
    }
}
