//
//  String+Extensions.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 17.11.20.
//  Copyright © 2020 Hacking with Swift. All rights reserved.
//

import Foundation

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
