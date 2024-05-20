//
//  NotificationModel.swift
//  TPISofware_Homework
//
//  Created by vfa on 20/05/2024.
//

import Foundation

struct NotificationResponseModel: Codable {
    let msgCode: String
    let msgContent: String
    let result: NotificationResultModel
}

struct NotificationResultModel: Codable {
    let messages: [NotificationMessagesModel]
}

struct NotificationMessagesModel: Codable {
    let status: Bool
    let updateDateTime: String
    let title: String
    let message: String
}
