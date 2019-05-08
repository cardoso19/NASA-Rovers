//
//  Rover.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

class Rover: Codable {
    let id: Int
    let name: String
    let landingDate: Date?
    let launchDate: Date?
    let status: RoverStatus
    let maxSol: Int
    let maxDate: Date?
    let totalPhotos: Int
    let cameras: [Camera]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case cameras
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        landingDate = try values.decode(String.self, forKey: .landingDate).convertToDate(ofFormat: "yyyy-MM-dd")
        launchDate = try values.decode(String.self, forKey: .launchDate).convertToDate(ofFormat: "yyyy-MM-dd")
        status = try values.decode(RoverStatus.self, forKey: .status)
        maxSol = try values.decode(Int.self, forKey: .maxSol)
        maxDate = try values.decode(String.self, forKey: .maxDate).convertToDate(ofFormat: "yyyy-MM-dd")
        totalPhotos = try values.decode(Int.self, forKey: .totalPhotos)
        cameras = try values.decode([Camera].self, forKey: .cameras)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(landingDate?.convertToString(onFormat: "yyyy-MM-dd"), forKey: .landingDate)
        try container.encode(launchDate?.convertToString(onFormat: "yyyy-MM-dd"), forKey: .launchDate)
        try container.encode(status, forKey: .status)
        try container.encode(maxSol, forKey: .maxSol)
        try container.encode(maxDate?.convertToString(onFormat: "yyyy-MM-dd"), forKey: .maxDate)
        try container.encode(totalPhotos, forKey: .totalPhotos)
        try container.encode(cameras, forKey: .cameras)
    }
}
