//
//  MenuItem.swift
//  LittleLemon
//
//  Created by Mert Özcan on 21.05.2024.
//

import Foundation

struct MenuItem: Decodable {
    let title: String
    let image: String
    let price: String
    // Optional properties from the JSON data
    let description: String?
    let category: String?
}
