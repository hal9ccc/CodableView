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

struct CVLabelModel: viewable {
    var uniqueId: UUID
    
    var text:           String
    var image:          String?
    var _image:         UIImage? = nil

    enum TextModelCodingKeys: String, CodingKey {
        case of
        case image
    }

    init(from decoder: Decoder) throws {
        uniqueId      = UUID()
        let container = try decoder.container(keyedBy: TextModelCodingKeys.self)
        text          = try container.decode(String.self, forKey: .of)
        image         = try container.decodeIfPresent(String.self, forKey: .image)  ?? ""
      //_image        = SFSymbol(rawValue: image!) ?? SFSymbol.questionmark
        _image        = UIImage(systemName: image!)
    }

}

struct ColorfulIconLabelStyle: LabelStyle {
    var color: Color
    var size: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        Label {
            configuration.title
        } icon: {
            configuration.icon
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 7 * size).frame(width: 28 * size, height: 28 * size)
                .foregroundColor(color))
        }
    }
}

struct LabelView: View {
    let model: CVLabelModel
    
    var body: some View {
        //let _: () = print("Label: '\(String(describing: model.text))'")
        Label("\(model.text)", systemImage: model.image!)
            .labelStyle(ColorfulIconLabelStyle(color: .orange, size: 1))
    }
}


struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextViewDemo()
        }
    }
}
