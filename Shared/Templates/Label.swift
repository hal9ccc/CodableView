//
//  Text.swift
//  CodableView
//
//  Created by Matthias Schulze on 14.11.20.

import SwiftUI
import SFSafeSymbols

//let SwiftFontDesigns: [String: Font.Design] = [
//    "default":      Font.Design.default,
//    "serif":        Font.Design.serif,
//    "rounded":      Font.Design.rounded,
//    "monospaced":   Font.Design.monospaced
//]

// Map Iterable Enum to Dictionary so the elements can be accessed by name
//let SwiftTextStyles  = Font.TextStyle.allCases.reduce(into: [String: Font.TextStyle]()) { $0["\($1)"] = $1 }

struct CVLabelModel: Decodable {
    var text:           String
    var image:          String?
    var _image:         SFSymbol? = nil

    enum TextModelCodingKeys: String, CodingKey {
        case of
        case image
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TextModelCodingKeys.self)
        text          = try container.decode(String.self, forKey: .of)
        image         = try container.decodeIfPresent(String.self, forKey: .image)  ?? ""
        _image        = SFSymbol(rawValue: image!) ?? SFSymbol.questionmark
    }

}


struct LabelView: View {
    let model: CVLabelModel
    
    var body: some View {
        Label("\(model.text)", systemImage: model._image!.rawValue)
    }
}

//struct TextTemplate: CVElement {
//    static func == (lhs: TextTemplate, rhs: TextTemplate) -> Bool {
//        return false
//    }
//
//    let id:     String?
//    let model:  CVTextModel
//
//    func render() -> AnyView {
//        return TextView(model: model).toAnyView()
//    }
//}


struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextViewDemo()
        }
    }
}
