//
//  ItemCellViewModel.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//

import Foundation

class ItemCellViewModel: DefaultCellViewModel {
    init(launchData: LaunchData) {
        super.init(nibName: "ItemTableViewCell", reuseId: "ItemTableViewCell", model: launchData)
    }
}
