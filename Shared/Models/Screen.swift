//
//  Screen.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 22.07.20.
//

import Foundation
import FirebaseFirestoreSwift

struct Application: Decodable {
    let screens: [Screen]
}

struct Screen: Identifiable, Decodable {
    var id: String
    var title: String
    var type: String
    var rows: [Row]?
    var items: [CVElement]?
    var rightButton: CVButton?

    enum ScreenCodingKeys: String, CodingKey {
        case id
        case title
        case type
        case rows
        case items
        case rightButton
    }


}

