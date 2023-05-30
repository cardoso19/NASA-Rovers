//
//  ErrorString.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

enum InternalErrors: Error {
    case responseError(Error)
    case parsingError
    case emptyData
    case requestCreationError
    case invalidURL
}
