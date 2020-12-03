//
//  Section.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 03.12.20.
//

import SwiftUI

struct CVSectionModel: viewable {
    var content:    [CVElement]?
    var header:     CVTextModel?
    var footer:     CVTextModel?
}

struct CVSection: View {
    let model: CVSectionModel
    @Namespace var sectionAnimation

    var body: some View {
        let headerElement: CVElement = CVElement (from: model.header)
        let footerElement: CVElement = CVElement (from: model.footer)

        Section (
            header: headerElement.render(),
            footer: footerElement.render(),
            content: {
                model.renderContent(namespace: sectionAnimation)
            }
        )
    }
}

struct SectionViewDemo: View {
   
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


struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionViewDemo()
        //CVListView(model: CVListModel(from:""))
    }
}
