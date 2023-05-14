//
//  Rover.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

struct Rover: Codable {
    let id: Int
    let name: String
    let landingDate: String
    let launchDate: String
    let status: RoverStatus

    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
    }
}
