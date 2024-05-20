//
//  AppDelegate.swift
//  TPISofware_Homework
//
//  Created by vfa on 17/05/2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let fir = HomeViewController()
        fir.navigationController?.isNavigationBarHidden = true
        self.window?.rootViewController = UINavigationController(rootViewController: fir)
                window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

   


}

