//
//  NotificationViewController.swift
//  TPISofware_Homework
//
//  Created by vfa on 20/05/2024.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var notificationTbv: UITableView!
    
    let viewModel: NotificationViewModel!
    
    init(viewModel: NotificationViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar()
        setUpTableView()
        self.title = "Notification"
    }
    
    private func setUpTableView() {
        notificationTbv.dataSource = self
        notificationTbv.delegate = self
        notificationTbv.register(UINib(nibName: "NotificationMessageCell", bundle: nil), forCellReuseIdentifier: "NotificationMessageCell")
    }
    
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationMessageCell", for: indexPath) as! NotificationMessageCell
        cell.configure(with: viewModel.notifications[indexPath.row])
        return cell
    }
    
    
    
}
