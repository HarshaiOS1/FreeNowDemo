//
//  VehicalListModel.swift
//  FreeNowDemo
//
//  Created by Harsha K on 01/11/20.
//

import Foundation
// MARK: - VehicalListModel
struct VehicalListModel: Codable {
    let poiList: [PoiList]?
}

// MARK: - PoiList
struct PoiList: Codable {
    let id: Int?
    let coordinate: Coordinate?
    let state: State?
    let type: TypeEnum?
    let heading: Double?
}

// MARK: - Coordinate
struct Coordinate: Codable {
    let latitude, longitude: Double?
}

enum State: String, Codable {
    case active = "ACTIVE"
    case inactive = "INACTIVE"
}

enum TypeEnum: String, Codable {
    case taxi = "TAXI"
}
