//
//  Created by Joh Robbins on 30/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import UIKit

class ErrorView: UIView {
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
            descriptionLabel.text = "Sorry, looks like something has gone wrong on our side. Please try again later"
        }
    }

    @IBAction func retryButtonTapped(_ sender: Any) {
        retryAction()
        removeFromSuperview()
    }
}
