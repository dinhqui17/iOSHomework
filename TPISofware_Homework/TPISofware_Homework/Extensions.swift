//
//  Extensions.swift
//  TPISofware_Homework
//
//  Created by vfa on 20/05/2024.
//

import UIKit

extension UIImage {
    static func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    completion(nil)
                }
            }.resume()
        }
}


extension UIViewController {
    func hideNavigationBar() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    func showNavigationBar() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
}

extension String {
    func formattedWithSeparator() -> String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            if let number = Double(self), let formattedNumber = formatter.string(from: NSNumber(value: number)) {
                return formattedNumber
            } else {
                return self
            }
        }
}
