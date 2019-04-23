//
//  RoverId.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 22/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

enum RoverId: Int {
    case curiosity
    case opportunity
    case spirit
    
    var name: String {
        switch self {
        case .curiosity:
            return "curiosity"
        case .opportunity:
            return "opportunity"
        case .spirit:
            return "spirit"
        }
    }
}
