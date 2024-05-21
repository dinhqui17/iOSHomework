//
//  MiddleButtonRepository.swift
//  TPISofware_Homework
//
//  Created by vfa on 21/05/2024.
//

import Foundation

class MiddleButtonRepository {
    
    @Published var getMiddleButtonItems: [MiddleButtonItemModel] = [
        MiddleButtonItemModel(label: "Transfer", image: "button00ElementMenuTransfer"),
        MiddleButtonItemModel(label: "Payment", image: "button00ElementMenuPayment"),
        MiddleButtonItemModel(label: "Utility", image: "button00ElementMenuUtility"),
        MiddleButtonItemModel(label: "QR pay scan", image: "button01Scan"),
        MiddleButtonItemModel(label: "My QR code", image: "button00ElementMenuQRcode"),
        MiddleButtonItemModel(label: "Top up", image: "button00ElementMenuTopUp")
    ]
    
}
