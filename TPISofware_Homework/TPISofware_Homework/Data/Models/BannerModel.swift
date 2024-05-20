//
//  BannerModel.swift
//  TPISofware_Homework
//
//  Created by vfa on 20/05/2024.
//

import Foundation

struct BannerResponseModel: Codable {
    let msgCode: String
    let msgContent: String
    let result: BannerResultModel
}

struct BannerResultModel: Codable {
    let bannerList: [BannerListModel]
}

struct BannerListModel: Codable {
    let adSeqNo: Int
    let linkUrl: String
}
