//
//  Model.swift
//  YouTube-Demo
//
//  Created by Uzair Majeed on 09/06/24.
//

import Foundation

struct Item: Codable {
    let title: String
    let publisher: String
    let date : String
    let xhd_image: String
}

struct ItemsResponse: Codable {
    let results: [Item]
}
