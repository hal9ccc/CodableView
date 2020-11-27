//
//  Text.swift
//  CodableView
//
//  Created by Matthias Schulze on 14.11.20.

import SwiftUI


let SwiftFontDesigns: [String: Font.Design] = [
    "default":      Font.Design.default,
    "serif":        Font.Design.serif,
    "rounded":      Font.Design.rounded,
    "monospaced":   Font.Design.monospaced
]

// Map Iterable Enum to Dictionary so the elements can be accessed by name
let SwiftTextStyles  = Font.TextStyle.allCases.reduce(into: [String: Font.TextStyle]()) { $0["\($1)"] = $1 }

struct CVTextModel: Decodable {
    var text:           String
    var textStyle:      String?
    var fontDesign:     String?
    var _textStyle:     Font.TextStyle? = nil
    var _fontDesign:    Font.Design? = nil

    enum TextModelCodingKeys: String, CodingKey {
        case of
        case style
        case fontDesign
    }

    init(from text: String) {
        self.text     = text
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TextModelCodingKeys.self)
        text          = try container.decode(String.self, forKey: .of)
        textStyle     = try container.decodeIfPresent(String.self, forKey: .style)  ?? ""
        fontDesign    = try container.decodeIfPresent(String.self, forKey: .fontDesign) ?? ""
        _textStyle    = SwiftTextStyles  [textStyle! ] ?? SwiftTextStyles  ["body"]!
        _fontDesign   = SwiftFontDesigns [fontDesign!] ?? SwiftFontDesigns ["default"]!
    }

}


struct TextView: View {
    let model: CVTextModel
    
    @State private var entry: String = ""

    var body: some View {
        Text("\(model.text)")
            .font(.system(model._textStyle!, design: model._fontDesign!))
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




struct TextViewDemo: View {
   
    var body: some View { buildFrom(json: """
        {
            "title": "Text Preview",
            "content": [
                { "Text": {"of": "largeTitle",                 "style": "largeTitle"    } },
                { "Text": {"of": "title",                      "style": "title"         } },
                { "Text": {"of": "headline",                   "style": "headline"      } },
                { "Text": {"of": "subheadline",                "style": "subheadline"   } },
                { "Text": {"of": "body",                       "style": "body"          } },
                { "Text": {"of": "callout",                    "style": "callout"       } },
                { "Text": {"of": "footnote",                   "style": "footnote"      } },
                { "Text": {"of": "caption",                    "style": "caption"       } },
                { "Text": {"of": "title serif",                "style": "title"         , "fontDesign": "serif"} },
                { "Text": {"of": "title rounded",              "style": "title"         , "fontDesign": "rounded"} },
                { "Text": {"of": "title monospaced",           "style": "title"         , "fontDesign": "monospaced"} }
            ]
        }
        """
        )
    }

}


struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextViewDemo()
        }
    }
}
