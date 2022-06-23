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
    var isSelected: Bool? = false

    enum CodingKeys: String, CodingKey {
        case id
        case friendlyURL = "friendly_url"
        case seoDescription = "seo_description"
        case title, type
        case isSelected
    }
}


struct Setting {
    let title: String?
    let caption: String?
    let settingType: SettingType?
}


enum SettingType: Int {
    case account = 30
    case langauge = 32
    case myactivity
    case termsofuse
    case privacy
    case contact
    case aboutus
    
    func selectedSettingItem() {
        switch self {
        case .account:
            print("Going to account")
        case .langauge:
            print("Going to language")
        case .myactivity:
            print("Going to my activity")
        case .termsofuse:
            print("Going to terms of use")
        case .privacy:
            print("Going to privacy")
        case .contact:
            print("Going to contact")
        case .aboutus:
            print("Going to about us")
        }
    }
}
