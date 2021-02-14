//
//  Place.swift
//  TourismApps
//
//  Created by Ghazian Fadhli Fakhrusy on 29/11/20.
//

import Foundation

struct RootPlace : Codable{
    let places: [PlaceData]
}

struct PlaceData : Codable{
    let id: Int
    let name: String
    let description: String
    let address: String
    let longitude: Double
    let latitude: Double
    let like: Int
    let image: String
}
