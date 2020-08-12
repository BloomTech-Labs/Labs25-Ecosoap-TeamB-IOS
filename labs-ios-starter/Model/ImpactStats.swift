//
//  ImpactStats.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/11/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

struct ImpactStats: Codable {
    let soapRecycled: Int?
    let linensRecycled: Int?
    let bottlesRecycled: Int?
    let paperRecycled: Int?
    let peopleServed: Int?
    let womenEmployed: Int?
}

struct ImpactStatsByPropertyIdPayload: Codable {
    let impactStats: ImpactStats
}
