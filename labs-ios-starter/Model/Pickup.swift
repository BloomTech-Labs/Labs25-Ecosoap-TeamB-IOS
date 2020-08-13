//
//  Pickup.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/11/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

enum Status: String {
    case SUBMITTED = "SUBMITTED"
    case OUT_FOR_PICKUP = "OUT_FOR_PICKUP"
    case COMPLETE = "COMPLETE"
    case CANCELLED = "CANCELLED"
}
enum CollectionType: String {
    case COURIER_CONSOLIDATED = "COURIER_CONSOLIDATED"
    case COURIER_DIRECT = "COURIER_DIRECT"
    case GENERATED_LABEL = "GENERATED_LABEL"
    case LOCAL = "LOCAL"
    case OTHER = "OTHER"
}
struct Pickup: Codable {
    let id: String
    let confirmNum: String
    let readyDate: Date!
    let pickupDate: Date
    let status: Status.RawValue!
    let collectionType: CollectionType.RawValue?
    let notes: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case confirmNum = "confirmationCode"
        case readyDate
        case pickupDate
        case notes
        case status
        case collectionType
    }
}

struct SchedulePickupPayload {
    let pickup: Pickup
    let label: URL?
}
