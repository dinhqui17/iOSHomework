//
//  FavoriteModel.swift
//  TPISofware_Homework
//
//  Created by vfa on 21/05/2024.
//

import Foundation

struct FavoriteResponseModel: Codable {
    let msgCode: String
    let msgContent: String
    let result: FavoriteResultModel
}

struct FavoriteResultModel: Codable {
    let favoriteList: [FavoriteListModel]
}

struct FavoriteListModel: Codable {
    let nickname: String
    let transType: String
    var imageName: String {
        switch transType {
        case "CUBC":
            return "button00ElementScrollTree"
        case "Mobile":
            return "button00ElementScrollMobile"
        case "PMF":
            return "button00ElementScrollBuilding"
        case "CreditCard":
            return "button00ElementScrollCreditCard"
        default:
            return ""
        }
    }
}
