//
//  User.swift
//  labs-ios-starter
//
//  Created by Lydia Zhang on 8/18/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: String?
    let email: String?
    let firstName: String?
    let lasrName: String?
    let properties: [Property]?
}
