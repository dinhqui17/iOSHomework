//
//  NavigationView.swift
//  TPISofware_Homework
//
//  Created by vfa on 17/05/2024.
//

import UIKit
import Combine

class NavigationView: UIView {
    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet var contentView: UIView!
    
    private let notificationViewModel = NotificationViewModel(notificationRepository: NotificationRepository())
    
    private var disposeBag = Set<AnyCancellable>()
    
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
    
    func bindingViewModel(viewModel: NotificationViewModel) {
        viewModel.$hasNewNotify
            .receive(on: DispatchQueue.main)
            .sink { [weak self] hasNewNotify in
                self?.notifyButton.setImage(UIImage(named: hasNewNotify ? "iconBell02Active" : "iconBell01Nomal"), for: .normal)
            }
            .store(in: &disposeBag)
    }
    
    @IBAction func notificationBtnTapped(_ sender: Any) {
        buttonTapHandler?()
    }
    
}
