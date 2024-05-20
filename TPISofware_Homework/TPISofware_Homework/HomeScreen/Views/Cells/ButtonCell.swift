//
//  ButtonCell.swift
//  TPISofware_Homework
//
//  Created by vfa on 18/05/2024.
//

import UIKit

class ButtonCell: UICollectionViewCell {

    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item: MiddleButtonItemModel) {
        titleLabel.text = item.label
        btn.setImage(UIImage(named: item.image), for: .normal)
    }

}
