//
//  ContentView.swift
//  BackendDrivenUI
//
//  Created by Mohammad Azam on 10/13/20.
//

import SwiftUI

struct DebugView: View {
    
    var body: some View { buildFrom(json: """
        {
            "id": "preview",
            "title": "Preview Screen",
            "type": "templates",
            "items": [
                { "itemType": "text", "data": {"text": "largeTitle",                 "textStyle": "largeTitle"   } },
                { "itemType": "text", "data": {"text": "title",                      "textStyle": "title"        } },
                { "itemType": "text", "data": {"text": "headline",                   "textStyle": "headline"     } },
                { "itemType": "text", "data": {"text": "subheadline",                "textStyle": "subheadline"  } },
                { "itemType": "text", "data": {"text": "body",                       "textStyle": "body"         } },
                { "itemType": "text", "data": {"text": "callout",                    "textStyle": "callout"      } },
                { "itemType": "text", "data": {"text": "footnote",                   "textStyle": "footnote"     } },
                { "itemType": "text", "data": {"text": "caption",                    "textStyle": "caption"      } },

                { "itemType": "text", "data": {"text": "largeTitle serif",           "textStyle": "largeTitle"    , "fontDesign": "serif"} },
                { "itemType": "text", "data": {"text": "largeTitle rounded",         "textStyle": "largeTitle"    , "fontDesign": "rounded"} },
                { "itemType": "text", "data": {"text": "largeTitle monospaced",      "textStyle": "title"         , "fontDesign": "monospaced"} },

                { "itemType": "text", "data": {"text": "this is the end",       "textStyle": "none"         } }
            ]
        }
        """
        )

    }
}

class DebugViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let controller = UIHostingController(rootView: DebugView())
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(controller)
        self.view.addSubview(controller.view)
        //self.title = screenVM.screen?.title
        controller.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            controller.view.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            controller.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

    }

}


struct _TestView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
