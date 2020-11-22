//
//  TextField.swift
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


struct TextModel: Decodable, CodableModel {
    var text:           String
    var textStyle:      String?
    var fontDesign:     String?
    var _textStyle:     Font.TextStyle? = nil
    var _fontDesign:    Font.Design? = nil

    enum TextModelCodingKeys: String, CodingKey {
        case text
        case textStyle
        case fontDesign
    }

    init(from text: String) {
        self.text     = text
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TextModelCodingKeys.self)
        text          = try container.decode(String.self, forKey: .text)
        textStyle     = try container.decodeIfPresent(String.self, forKey: .textStyle)  ?? ""
        fontDesign    = try container.decodeIfPresent(String.self, forKey: .fontDesign) ?? ""
        _textStyle    = SwiftTextStyles  [textStyle! ] ?? SwiftTextStyles  ["body"]!
        _fontDesign   = SwiftFontDesigns [fontDesign!] ?? SwiftFontDesigns ["default"]!
    }

}


struct TextView: View {
    let model: TextModel
    
    @State private var entry: String = ""

    var body: some View {
        Text("\(model.text)")
            .font(.system(model._textStyle!, design: model._fontDesign!))
    }
}

struct TextTemplate: UITemplate {
    static func == (lhs: TextTemplate, rhs: TextTemplate) -> Bool {
        return false
    }
    
    let id:     String?
    let model:  TextModel
    
    func render() -> AnyView {
        return TextView(model: model).toAnyView()
    }
}




struct TextViewDemo: View {
   
    var body: some View { buildFrom(json: """
        {
            "id": "preview",
            "title": "Preview Screen",
            "type": "templates",
            "items": [
                { "id":"1", "itemType": "text", "data": {"text": "largeTitle",                 "textStyle": "largeTitle"    } },
                { "id":"2", "itemType": "text", "data": {"text": "title",                      "textStyle": "title"         } },
                { "id":"3", "itemType": "text", "data": {"text": "headline",                   "textStyle": "headline"      } },
                { "id":"4", "itemType": "text", "data": {"text": "subheadline",                "textStyle": "subheadline"   } },
                { "id":"5", "itemType": "text", "data": {"text": "body",                       "textStyle": "body"          } },
                { "id":"6", "itemType": "text", "data": {"text": "callout",                    "textStyle": "callout"       } },
                { "id":"7", "itemType": "text", "data": {"text": "footnote",                   "textStyle": "footnote"      } },
                { "id":"8", "itemType": "text", "data": {"text": "caption",                    "textStyle": "caption"       } },
                { "id":"9", "itemType": "text", "data": {"text": "title serif",                "textStyle": "title"         , "fontDesign": "serif"} },
                { "id":"0", "itemType": "text", "data": {"text": "title rounded",              "textStyle": "title"         , "fontDesign": "rounded"} },
                { "id":"a", "itemType": "text", "data": {"text": "title monospaced",           "textStyle": "title"         , "fontDesign": "monospaced"} }

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
            TextViewDemo()
        }
    }
}
