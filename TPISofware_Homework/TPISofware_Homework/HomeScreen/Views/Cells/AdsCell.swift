//
//  AdsCell.swift
//  TPISofware_Homework
//
//  Created by vfa on 19/05/2024.
//

import UIKit

class AdsCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with imageString: String) {
        if let url = URL(string: imageString) {
            UIImage.loadImage(from: url) { image in
                self.imageView.image = image
                self.imageView.contentMode = .scaleAspectFit
            }
        }
        
    }
}
