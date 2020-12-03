//
//  Form.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 02.12.20.
//

import SwiftUI

struct CVFormModel: viewable {
    var content: [CVElement]?
}

struct CVForm: View {
    let model: CVFormModel
    @Namespace var formAnimation

    var body: some View {
        Form {
            model.renderContent(namespace: formAnimation)
        }
    }
}

struct FormViewDemo: View {
   
    var body: some View { buildFrom(json: """
        {
            "id": "Main",
            "content": [
                { "List": {
                    "style": "grouped",
                    "content": [
                        { "Label": {"of": "Sun",                "image": "sun.max"       } },
                        { "Label": {"of": "Cloud",              "image": "cloud"         } },
                        { "Label": {"of": "Rain",               "image": "cloud.rain"    } },
                        { "Label": {"of": "Last Label",         "image": "ball"          } }
                    ]
                } }
            ]
        }
        """
        )
    }

}


struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormViewDemo()
        //CVListView(model: CVListModel(from:""))
    }
}
