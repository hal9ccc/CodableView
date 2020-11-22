//
//  Button.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 22.07.20.
//

import Foundation

struct CVButton: Decodable, HasAction {
    var title: String
    var action: Action? = nil

    enum ButtonCodingKeys: String, CodingKey {
        case title
        case action
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ActionCodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        action = try decodeAction(from: container)
    }
    
    //init(from encoder: Encoder) throws {
    //    var container = encoder.container(keyedBy: ButtonCodingKeys.self)
    //    try container.encode(title, forKey: .title)
    //    var _action = container.nestedContainer(keyedBy: ButtonCodingKeys.self, forKey: .action)
    //    try _action.encode(action, forKey: .action)
    //}
}

