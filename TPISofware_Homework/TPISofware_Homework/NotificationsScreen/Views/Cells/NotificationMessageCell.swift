//
//  NotificationMessageCell.swift
//  TPISofware_Homework
//
//  Created by vfa on 20/05/2024.
//

import UIKit

class NotificationMessageCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Setup UI
        checkedView.layer.cornerRadius = checkedView.frame.size.height / 2
        checkedView.clipsToBounds = true
    }
    
    func configure(with notification: NotificationMessagesModel) {
        checkedView.isHidden = notification.status
        titleLabel.text = notification.title
        dateLabel.text = notification.updateDateTime
        contentLabel.text = notification.message
    }
    
}
