//
//  VStack.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 25.11.20.
//

import SwiftUI

struct CVVStackModel: Decodable {

    var content: [CVElement]? = nil
    
    enum keys: String, CodingKey {
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: keys.self)
        content       = try container.decodeIfPresent([CVElement].self, forKey: .content)  ?? [CVElement]()
    }

}


struct CVVStackView: View {
    let model: CVVStackModel
    @Namespace var vStackAnimation

    var body: some View {
        let _: () = print("VStack")
        let _: () = print("contents: \(String(describing: model.content))")
        
        VStack {
            renderContent(content: model.content, namespace: vStackAnimation)
        }
    }
}

struct VStackDemo: View {
   
    var body: some View { buildFrom(json: """
        {
            "title": "List Preview",
            "content": [
                { "List": { "content": [
                    { "Text": {"text": "largeTitle",                 "textStyle": "largeTitle"    } },
                    { "Text": {"text": "title",                      "textStyle": "title"         } },
                    { "Text": {"text": "headline",                   "textStyle": "headline"      } },
                    { "Text": {"text": "subheadline",                "textStyle": "subheadline"   } },
                    { "Text": {"text": "body",                       "textStyle": "body"          } },
                    { "Text": {"text": "callout",                    "textStyle": "callout"       } },
                    { "Text": {"text": "footnote",                   "textStyle": "footnote"      } },
                    { "Text": {"text": "caption",                    "textStyle": "caption"       } },
                    { "Text": {"text": "title serif",                "textStyle": "title"         , "fontDesign": "serif"} },
                    { "Text": {"text": "title rounded",              "textStyle": "title"         , "fontDesign": "rounded"} },
                    { "Text": {"text": "title monospaced",           "textStyle": "title"         , "fontDesign": "monospaced"} }
                ] } }
            ]
        }
        """
        )
    }

}


struct VStackView_Previews: PreviewProvider {
    static var previews: some View {
         VStackDemo()
    }
}
