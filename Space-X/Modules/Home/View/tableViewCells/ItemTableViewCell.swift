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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var patchImageView: UIImageView! {
        didSet {
            patchImageView.circle()
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
        if let launchDate = model.dateLocal?.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ").toString(withFormat: "yyyy-MM-dd") {
            launchDateLabel.text = "launch date: \(launchDate)"
        }
        setPathcImage(with: model.links?.patch?.small)
    }
    
    func setPathcImage(with stringUrl: String?) {
        if let stringUrl = stringUrl, let url = URL(string: stringUrl) {
            patchImageView.setImage(with: url)
        }
    }
}
