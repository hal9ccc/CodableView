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

//let SwiftColors: [String: Color] = [
//    "clear":        Color.clear,
//    "black":        Color.black,
//    "white":        Color.white,
//    "gray":         Color.gray,
//    "red":          Color.red,
//    "green":        Color.green,
//    "blue":         Color.blue,
//    "orange":       Color.orange,
//    "yellow":       Color.yellow,
//    "pink":         Color.pink,
//    "purple":       Color.purple,
//    "primary":      Color.primary,
//    "secondary":    Color.secondary
//]

// Map Iterable Enum to Dictionary so the elements can be accessed by name
let SwiftTextStyles  = Font.TextStyle.allCases.reduce(into: [String: Font.TextStyle]()) { $0["\($1)"] = $1 }

struct CVTextModel: viewable {
   
    var content: [CVElement]?

    var text:                   String
    var color:                  String? = ""
    var backgroundColor:        String? = ""
    var style:                  String? = ""
    var fontDesign:             String? = ""

    enum TextModelCodingKeys:   String, CodingKey {
        case text = "of"
    }

    init(from text: String) {
        self.content  = [CVElement]()
        self.text     = text
    }
    
}


struct CVText: View {
    let model: CVTextModel
    
    var body: some View {

        let _textStyle    = SwiftTextStyles  [model.style       ?? ""] ?? SwiftTextStyles  ["body"]!
        let _fontDesign   = SwiftFontDesigns [model.fontDesign  ?? ""] ?? SwiftFontDesigns ["default"]!
//        let _color        = SwiftColors      [model.color       ?? ""] ?? SwiftColors      ["primary"]!

        //print("color:\(_color)")
        //let _: () = print("color:\(model.color)")
        
        Text("\(model.text)")
            .font(.system(_textStyle, design: _fontDesign))
            .colored(with: model.color, backgroundColor: model.backgroundColor)
    }
}


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
