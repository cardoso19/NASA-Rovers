//
//  Photo.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

class Photo: Codable {
    let id: Int
    let sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: Date?
    let rover: Rover
    
    enum CodingKeys: String, CodingKey {
        case id
        case sol
        case camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        sol = try values.decode(Int.self, forKey: .sol)
        camera = try values.decode(Camera.self, forKey: .camera)
        imgSrc = try values.decode(String.self, forKey: .imgSrc)
        earthDate = try values.decode(String.self, forKey: .earthDate).convertToDate(ofFormat: "yyyy-MM-dd")
        rover = try values.decode(Rover.self, forKey: .rover)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(sol, forKey: .sol)
        try container.encode(camera, forKey: .camera)
        try container.encode(imgSrc, forKey: .imgSrc)
        try container.encode(earthDate?.convertToString(onFormat: "yyyy-MM-dd"), forKey: .earthDate)
        try container.encode(rover, forKey: .rover)
    }
}
