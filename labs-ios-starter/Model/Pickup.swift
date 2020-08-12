//
//  Pickup.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/11/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

enum Status {
    case SUBMITTED
    case OUT_FOR_PICKUP
    case COMPLETE
    case CANCELLED
}
enum CollectionType {
    case COURIER_CONSOLIDATED
    case COURIER_DIRECT
    case GENERATED_LABEL
    case LOCAL
    case OTHER
}
struct Pickup {
    let id: String
    let confirmNum: String
    let readyDate: Date!
    let pickupDate: Date
    let status: Status!
    let collectionType: CollectionType?
    let notes: String
    
    init(id: String, confirmNum: String, readyDate: Date!, pickupDate: Date, status: Status! = .SUBMITTED,collectionType: CollectionType? = nil,notes:String) {
        self.id = id
        self.confirmNum = confirmNum
        self.readyDate = readyDate
        self.pickupDate = pickupDate
        self.status = status
        self.collectionType = collectionType
        self.notes = notes
    }
    

    
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
