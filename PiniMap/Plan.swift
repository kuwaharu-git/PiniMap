//
//  Plan.swift
//  PiniMap
//
//  Created by kuwaharu on 2025/04/29.
//

import Foundation

struct Plan: Identifiable, Codable {
    let id: UUID
    var title: String
    var pins: [Pin] = []
}

struct Pin: Identifiable, Codable {
    let id: UUID
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
}
