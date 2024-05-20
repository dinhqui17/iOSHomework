//
//  FavoriteButtonCell.swift
//  TPISofware_Homework
//
//  Created by vfa on 18/05/2024.
//

import UIKit

class FavoriteButtonCell: UICollectionViewCell {

    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with item: FavoriteItemModel) {
        label.text = item.label
        btn.setImage(UIImage(named: item.image), for: .normal)
    }

}
