//
//  StringUtil.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

extension String {
    func convertToDate(ofFormat format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
