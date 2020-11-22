//
//  Row.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 22.07.20.
//

import Foundation

struct Row: Decodable, HasAction {
    let title: String
    var action: Action? = nil

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ActionCodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        action = try decodeAction(from: container)
    }
}
