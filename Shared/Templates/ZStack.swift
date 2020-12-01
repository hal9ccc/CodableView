//
//  VStack.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 25.11.20.
//

import SwiftUI

struct CVZStackModel: viewable {
    var content: [CVElement]?
}


struct CVZStack: View {
    let model: CVZStackModel
    @Namespace var ZStackAnimation

    var body: some View {
//        let _: () = print("VStack")
//        let _: () = print("contents: \(String(describing: model.content))")
        
        ZStack {
            model.renderContent(namespace: ZStackAnimation)
        }
    }
}

struct ZStackDemo: View {
   
    var body: some View { buildFrom(json: """
        {
            "title": "List Preview",
            "content": [
                { "ZStack": { "content": [
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


struct ZStackView_Previews: PreviewProvider {
    static var previews: some View {
         ZStackDemo()
    }
}
