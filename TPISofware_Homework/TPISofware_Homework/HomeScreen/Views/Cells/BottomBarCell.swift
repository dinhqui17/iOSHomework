//
//  BottomBarCell.swift
//  TPISofware_Homework
//
//  Created by vfa on 19/05/2024.
//

import UIKit

class BottomBarCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item: BottomBarItemModel) {
        label.text = item.label
        imageView.image = UIImage(named: item.image)
    }
        
}
