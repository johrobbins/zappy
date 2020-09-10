//
//  Created by Joh Robbins on 30/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class SevenDayWeatherView: UIView, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var tableView: UITableView!

    private var weather: Weather?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadViewFromNib() {
        Bundle.main.loadNibNamed("SevenDayWeatherView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    func configure(_ weather: Weather) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero

        tableView.register(UINib(nibName: String(describing: DailyForecastTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DailyForecastTableViewCell.self))

        self.weather = weather
        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather?.daily.data.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyForecastTableViewCell.self), for: indexPath) as! DailyForecastTableViewCell

        //TODO: remove weather?.daily.data[0] as this is current day
        if let currentDay = weather?.daily.data, let timezone = weather?.timezone {
            cell.configure(currentDay: currentDay[indexPath.row], timezone: timezone)
            return cell
        }

        return cell
    }
}
