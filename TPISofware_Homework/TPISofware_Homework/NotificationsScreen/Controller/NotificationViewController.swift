//
//  NotificationViewController.swift
//  TPISofware_Homework
//
//  Created by vfa on 20/05/2024.
//

import UIKit

class NotificationViewController: UIViewController {
    
    private let viewModel = NotificationViewModel()
    private var notifications: [NotificationMessagesModel] = []
    @IBOutlet weak var notificationTbv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar()
        setUpData()
        setUpTableView()
        self.title = "Notification"
    }
    
    private func setUpTableView() {
        notificationTbv.dataSource = self
        notificationTbv.delegate = self
        notificationTbv.register(UINib(nibName: "NotificationMessageCell", bundle: nil), forCellReuseIdentifier: "NotificationMessageCell")
    }
    
    private func setUpData() {
        viewModel.getNotifications(endpoint: .notEmpty)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            },
                  receiveValue: { [self] result in
                notifications = result
                notificationTbv.reloadData()
            })
            .store(in: &viewModel.subscriptions)
    }
    
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationMessageCell", for: indexPath) as! NotificationMessageCell
        cell.configure(with: notifications[indexPath.row])
        return cell
    }
    
    
    
}
