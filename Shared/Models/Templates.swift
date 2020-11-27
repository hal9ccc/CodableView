//
//  Templates.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 12.11.20.
//

import Foundation
import SwiftUI

//protocol HasCodableModel { }
//
//enum TemplateType: String, Decodable {
//    case text
//    case textfield
//    case chart
//    case roundedImage
//    case gradientBox
//}
//
//extension HasCodableModel {
//    func decodeModel(from container: KeyedDecodingContainer<ModelCodingKeys>) throws -> CodableModel? {
//        if let modelType = try container.decodeIfPresent(String.self, forKey: .itemType) {
//            switch modelType {
//                case "text":            return try container.decode(CVTextModel.self,         forKey: .data)
//                case "chart":           return try container.decode(ChartModel.self,        forKey: .data)
//                case "textfield":       return try container.decode(TextfieldModel.self,    forKey: .data)
//                case "gradientBox":     return try container.decode(GradientBoxModel.self,  forKey: .data)
//                case "roundedImage":    return try container.decode(RoundedImageModel.self, forKey: .data)
////                default: fatalError("Unknown model type: \(modelType).")
//            default:                    return try container.decode(CVTextModel.self,         forKey: .data)
//
//            }
//        } else {
//            return nil
//        }
//    }
//}
//
//enum ModelCodingKeys: String, CodingKey {
//    case id
//    case itemType
//    case data
//}
//
//protocol CodableModel: Decodable {
//
//}

protocol UITemplate {
    var uniqueId: UUID { get }
    func render() -> AnyView
}

extension UITemplate {
    var id: String { "\(UUID())" }
    var uniqueId: UUID { UUID() }
}


struct CVElement: Identifiable, Decodable {
    var id: String? = "\(UUID())"

    var Text:           CVTextModel? = nil
    var Label:          CVLabelModel? = nil

    var VStack:         CVVStackModel? = nil
    var List:           CVListModel? = nil

    var content: [CVElement]? = [CVElement]()
    
    
    func render() -> AnyView {
        if Text         != nil { return TextView        (model: Text!       ).toAnyView() }
        if Label        != nil { return LabelView       (model: Label!      ).toAnyView() }

        if VStack       != nil { return CVVStackView    (model: VStack!     ).toAnyView() }
        if List         != nil { return CVListView      (model: List!       ).toAnyView() }

        return SwiftUI.Text("no data").toAnyView()
    }
    
   
}



struct SharedTemplate: Decodable {
    let pageTitle: String
    let templates: [CVElement]
}

