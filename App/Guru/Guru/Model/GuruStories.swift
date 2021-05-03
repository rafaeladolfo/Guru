//
//  GuruStories.swift
//  Guru
//
//  Created by Rafael Adolfo  on 03/05/21.
//

import Foundation

// MARK: - Stories
struct GuruStories: Codable {
    let items: [LeItem]
}

// MARK: - Item
struct LeItem: Codable {
    let title: String
    let origin: Origin
    let link: String
    let isPriority: Bool
    let image: String
    let published: String

    enum CodingKeys: String, CodingKey {
        case title, origin, link
        case isPriority
        case image, published
    }
}

enum Origin: String, Codable {
    case infoMoney = "InfoMoney"
    case suno = "Suno"
}
