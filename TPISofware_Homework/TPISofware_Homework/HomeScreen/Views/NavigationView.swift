//
//  NavigationView.swift
//  TPISofware_Homework
//
//  Created by vfa on 17/05/2024.
//

import UIKit
import Combine

class NavigationView: UIView {
    

    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet var contentView: UIView!
    
    var buttonTapHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }

    
    private func setUpView() {
        Bundle.main.loadNibNamed("NavigationView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func notificationBtnTapped(_ sender: Any) {
        buttonTapHandler?()
    }
    
}
