//
//  Actions.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 22.07.20.
//

import Foundation

protocol HasAction { }

extension HasAction {
    func decodeAction(from container: KeyedDecodingContainer<ActionCodingKeys>) throws -> Action? {
        if let actionType = try container.decodeIfPresent(String.self, forKey: .actionType) {
            switch actionType {
                case "alert":           return try container.decode(AlertAction.self,           forKey: .action)
                case "fetch":           return try container.decode(FetchAction.self,           forKey: .action)
                case "showWebsite":     return try container.decode(ShowWebsiteAction.self,     forKey: .action)
                case "showScreen":      return try container.decode(ShowScreenAction.self,      forKey: .action)
                case "showStaticView":  return try container.decode(ShowStaticViewAction.self,  forKey: .action)
                case "share":           return try container.decode(ShareAction.self,           forKey: .action)
                case "playMovie":       return try container.decode(PlayMovieAction.self,       forKey: .action)
            default:
                fatalError("Unknown action type: \(actionType).")
            }
        } else {
            return nil
        }
    }
}

enum ActionCodingKeys: String, CodingKey {
    case title
    case actionType
    case action
}

protocol Action: Decodable {
    var presentsNewScreen: Bool { get }
}

struct AlertAction: Action {
    let title: String
    let message: String

    var presentsNewScreen: Bool {
        return false
    }
}

struct FetchAction: Action {
    let title: String
    let message: String

    var presentsNewScreen: Bool {
        return false
    }
}

struct ShowStaticViewAction: Action {
    let id: String

    var presentsNewScreen: Bool {
        return true
    }
}


struct ShowWebsiteAction: Action {
    let url: URL

    var presentsNewScreen: Bool {
        return true
    }
}

struct ShowScreenAction: Action {
    let id: String

    var presentsNewScreen: Bool {
        return true
    }
}

struct ShareAction: Action {
    let text: String?
    let url: URL?

    var presentsNewScreen: Bool {
        return false
    }
}

struct PlayMovieAction: Action {
    let url: URL

    var presentsNewScreen: Bool {
        return true
    }
}
