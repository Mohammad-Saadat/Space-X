//
//  ItemTableViewCell.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    // ==================
    // MARK: - Properties
    // ==================
    
    // MARK: Private
    
    // ===============
    // MARK: - Outlets
    // ===============
    
    // MARK: Labels
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var detailsLabel: UILabel!
    @IBOutlet private weak var launchDateLabel: UILabel!
    @IBOutlet private weak var rocketImageView: UIImageView! {
        didSet {
            rocketImageView.circle()
        }
    }
}

extension ItemTableViewCell: Binder {
    func bind(_ viewModel: Any) {
        if let viewModel = viewModel as? ItemCellViewModel,
            let model = viewModel.getModel() as? LaunchData {
            setup(with: model)
        }
    }
}

private extension ItemTableViewCell {
    func setup(with model: LaunchData) {
        nameLabel.text = model.name
        detailsLabel.text = model.details
        launchDateLabel.text = model.dateLocal?.toString()
        setRocketImage(with: model.links?.patch?.small)
    }
    
    func setRocketImage(with stringUrl: String?) {
        if let stringUrl = stringUrl, let url = URL(string: stringUrl) {
            rocketImageView.setImage(with: url)
        }
    }
}
