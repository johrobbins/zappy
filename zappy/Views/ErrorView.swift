//
//  Created by Joh Robbins on 30/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet var errorView: UIView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var retryButton: UIButton!

    private var retryAction: () -> Void

    override init(frame: CGRect) {
        self.retryAction = {}
        super.init(frame: frame)
        loadViewFromNib()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadViewFromNib() {
        Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    private func setupUI() {
        errorView.layer.shadowColor = UIColor.black.cgColor
        errorView.layer.shadowOpacity = 0.35
        errorView.layer.shadowOffset = .zero
        errorView.layer.shadowRadius = 10
        errorView.layer.cornerRadius = 4

        retryButton.layer.cornerRadius = 4
    }

    func configure(error: APIService.RequestError, action:@escaping () -> Void) {
        retryAction = action

        switch error {
        case .networkError(let networkError):
            descriptionLabel.text = networkError.localizedDescription
        case .dataNotFound, .jsonParsingError(_):
            descriptionLabel.text = "Please try again"
        }
    }

    @IBAction func retryButtonTapped(_ sender: Any) {
        retryAction()
        removeFromSuperview()
    }
}
