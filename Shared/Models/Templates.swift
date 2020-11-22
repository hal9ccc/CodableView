//
//  Templates.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 12.11.20.
//

import Foundation
import SwiftUI

protocol HasCodableModel { }

enum TemplateType: String, Decodable {
    case text
    case textfield
    case chart
    case roundedImage
    case gradientBox
}

extension HasCodableModel {
    func decodeModel(from container: KeyedDecodingContainer<ModelCodingKeys>) throws -> CodableModel? {
        if let modelType = try container.decodeIfPresent(String.self, forKey: .itemType) {
            switch modelType {
                case "text":            return try container.decode(TextModel.self,         forKey: .data)
                case "chart":           return try container.decode(ChartModel.self,        forKey: .data)
                case "textfield":       return try container.decode(TextfieldModel.self,    forKey: .data)
                case "gradientBox":     return try container.decode(GradientBoxModel.self,  forKey: .data)
                case "roundedImage":    return try container.decode(RoundedImageModel.self, forKey: .data)
//                default: fatalError("Unknown model type: \(modelType).")
            default:                    return try container.decode(TextModel.self,         forKey: .data)

            }
        } else {
            return nil
        }
    }
}

enum ModelCodingKeys: String, CodingKey {
    case id
    case itemType
    case data
}

protocol CodableModel: Decodable {

}

protocol UITemplate {
    var uniqueId: UUID { get }
    func render() -> AnyView
}

extension UITemplate {
    var id: String { "\(UUID())" }
    var uniqueId: UUID { UUID() }
}


//extension HasCodableModel: Hashable {
//    static func == (lhs: GridPoint, rhs: GridPoint) -> Bool {
//        return lhs.x == rhs.x && lhs.y == rhs.y
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(x)
//        hasher.combine(y)
//    }
//}





struct TemplateItem: Identifiable, Decodable, HasCodableModel {
    var id: String = "\(UUID())"
    let itemType: TemplateType
    var data: CodableModel? = nil
    var items: [TemplateItem]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ModelCodingKeys.self)
        let typeStr = try container.decode(String.self, forKey: .itemType)
        if TemplateType(rawValue: typeStr) != nil {
            itemType = TemplateType(rawValue: typeStr)!
        } else {
            itemType = TemplateType.textfield
        }
        data = try decodeModel(from: container)!
    }
}



struct SharedTemplate: Decodable {
    let pageTitle: String
    let templates: [TemplateItem]
}

