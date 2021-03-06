//
//  VStack.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 25.11.20.
//

import SwiftUI

struct CVVStackModel: viewable {
    var content: [CVElement]?
}


struct CVVStack: View {
    let model: CVVStackModel
    @Namespace var VStackAnimation

    var body: some View {
        VStack {
            model.renderContent(namespace: VStackAnimation)
        }
    }
}

struct VStackDemo: View {
   
    var body: some View { buildFrom(json: """
        {
            "title": "List Preview",
            "content": [
                { "List": { "content": [
                    { "Text": {"text": "largeTitle",                 "style": "largeTitle"    } },
                    { "Text": {"text": "title",                      "style": "title"         } },
                    { "Text": {"text": "headline",                   "style": "headline"      } },
                    { "Text": {"text": "subheadline",                "style": "subheadline"   } },
                    { "Text": {"text": "body",                       "style": "body"          } },
                    { "Text": {"text": "callout",                    "style": "callout"       } },
                    { "Text": {"text": "footnote",                   "style": "footnote"      } },
                    { "Text": {"text": "caption",                    "style": "caption"       } },
                    { "Text": {"text": "title serif",                "style": "title"         , "fontDesign": "serif"} },
                    { "Text": {"text": "title rounded",              "style": "title"         , "fontDesign": "rounded"} },
                    { "Text": {"text": "title monospaced",           "style": "title"         , "fontDesign": "monospaced"} }
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
