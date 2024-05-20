//
//  AccountBalanceModel.swift
//  TPISofware_Homework
//
//  Created by vfa on 20/05/2024.
//

import Foundation

struct BalanceResponseModel: Codable {
    let msgCode: String
    let msgContent: String
    let result: BalanceResultModel
}

struct BalanceResultModel: Codable {
    let fixedDepositList: [BalanceAccountModel]?
    let savingsList: [BalanceAccountModel]?
    let digitalList: [BalanceAccountModel]?
}

struct BalanceAccountModel: Codable {
    let account: String
    let curr: String
    let balance: Double
}
