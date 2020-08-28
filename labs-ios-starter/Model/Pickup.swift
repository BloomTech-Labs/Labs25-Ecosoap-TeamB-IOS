//
//  Pickup.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/11/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

// MARK: - All the initialized properties are set to make a fake data as template

enum Status: String {
    case sub = "SUBMITTED"
    case out = "OUT_FOR_PICKUP"
    case com = "COMPLETE"
    case can = "CANCELLED"
}
enum CollectionType: String {
    case c_c = "COURIER_CONSOLIDATED"
    case c_d = "COURIER_DIRECT"
    case g_l = "GENERATED_LABEL"
    case loc = "LOCAL"
    case oth = "OTHER"
}
enum PropertyType: String {
    case b_b = "BED_AND_BREAKFAST"
    case guest = "GUESTHOUSE"
    case hot = "HOTEL"
    case oth = "OTHER"
}
enum HospitalityService: String {
    case bot = "BOTTLES"
    case pap = "PAPER"
    case oth = "OTHER"
    case soa = "SOAP"
    case lin = "LINENS"
}
struct PickupCarton: Codable {
    let id: String
    let product: String
    let percentFull: Int
}


struct Pickup: Codable {
    let id: String?
    let confirmNum: String?
    let readyDate: String?
    let pickupDate: String?
    let status: String?
    let collectionType: String?
    let notes: String?
    let cartons: [PickupCarton]?
    let property: Property?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case confirmNum = "confirmationCode"
        case readyDate
        case pickupDate
        case notes
        case status
        case collectionType
        case cartons
        case property
    }
        
}
struct Property: Codable {
    let id: String?
    let name: String?
    let propertyType: String?
    let rooms: Int?
    let services: [String]?
    let collectionType: String?
    let pickups: [Pickup]?
    
}

struct SchedulePickupPayload {
    let pickup: Pickup
    let label: URL?
}
