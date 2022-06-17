//
//  MenuModel.swift
//  MoviesApp
//
//  Created by Saikiran Panuganti on 17/06/22.
//

import Foundation

// MARK: - HomeDMenuModelata
struct MenuModel: Codable {
    let statusCode: Int?
    let body: MenuBody?
}

// MARK: - Body
struct MenuBody: Codable {
    let total: Int?
    let data: [Menu]?
}

// MARK: - Datum
struct Menu: Codable {
    let id: Int?
    let friendlyURL, seoDescription, title, type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case friendlyURL = "friendly_url"
        case seoDescription = "seo_description"
        case title, type
    }
}
