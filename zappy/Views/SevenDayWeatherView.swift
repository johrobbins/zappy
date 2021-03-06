//
//  Created by Joh Robbins on 30/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class SevenDayWeatherView: UIView, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private var tableView: UITableView!

    private var sevenDayList: [CurrentDay]?
    private var timezone: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ weather: Weather) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero

        tableView.register(UINib(nibName: String(describing: DailyForecastTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DailyForecastTableViewCell.self))

        var dailyData = weather.daily.data
        dailyData.removeFirst() // Remove first element which contains `Today` data
        self.sevenDayList = dailyData

        self.timezone = weather.timezone

        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sevenDayList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyForecastTableViewCell.self), for: indexPath) as! DailyForecastTableViewCell

        if let currentDay = sevenDayList, let timezone = timezone {
            cell.configure(currentDay: currentDay[indexPath.row], timezone: timezone)
            return cell
        }

        return cell
    }
}
