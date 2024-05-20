//
//  HomeViewController.swift
//  TPISofware_Homework
//
//  Created by vfa on 17/05/2024.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    @IBOutlet weak var bottomBarView: BottomBarView!
    @IBOutlet weak var buttonAreaView: ButtonAreaView!
    @IBOutlet weak var adsView: AdsView!
    @IBOutlet weak var favoriteView: FavoriteView!
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var balanceView: BalanceView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomBarView.layer.cornerRadius = bottomBarView.frame.size.height / 2
        bottomBarView.clipsToBounds = true
        
        setPush()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigationBar()
    }
    
    private func setPush() {
        navigationView.buttonTapHandler = { [weak self] in
            print("asdas")
            let notificationVC = NotificationViewController()
                    self?.navigationController?.pushViewController(notificationVC, animated: true)
        }
    }
    

    

    
}


