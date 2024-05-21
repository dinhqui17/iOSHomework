//
//  HomeViewController1.swift
//  TPISofware_Homework
//
//  Created by vfa on 21/05/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomBarView: BottomBarView!
    @IBOutlet weak var buttonAreaView: ButtonAreaView!
    @IBOutlet weak var adsView: AdsView!
    @IBOutlet weak var favoriteView: FavoriteView!
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var balanceView: BalanceView!
    
    private let refreshControl = UIRefreshControl()
    
    private let balanceViewModel = BalanceViewModel(usdBalanceRepository: USDHomeBalanceRepository(), khrBalanceRepository: KHRHomeBalanceRepository())
    
    private let favoriteViewModel = FavoriteViewModel(favoriterRepository: FavoriteRepository())
    
    private let notificationViewModel = NotificationViewModel(notificationRepository: NotificationRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        balanceView.viewModel = balanceViewModel
        balanceView.bindingViewModel(viewModel: balanceViewModel)
        favoriteView.viewModel = favoriteViewModel
        favoriteView.bindingViewModel(viewModel: favoriteViewModel)
        balanceViewModel.refreshBalance()
        favoriteViewModel.loadFavorites()
        notificationViewModel.loadNotification()
        navigationView.bindingViewModel(viewModel: notificationViewModel)
        setUpRefreshControl()
        setPush()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigationBar()
    }
    
    private func setUpRefreshControl() {
        scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    @objc private func handleRefresh() {
        balanceViewModel.refreshBalance()
        favoriteViewModel.loadFavorites()
        notificationViewModel.loadNotification()
        refreshControl.endRefreshing()
    }
    
    private func setPush() {
        navigationView.buttonTapHandler = { [weak self] in
            let notificationVC = NotificationViewController(viewModel: self?.notificationViewModel)
            self?.navigationController?.pushViewController(notificationVC, animated: true)
        }
    }
}
