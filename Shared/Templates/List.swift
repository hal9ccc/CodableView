//
//  List.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 25.11.20.
//

import SwiftUI



// Map Iterable Enum to Dictionary so the elements can be accessed by name
//let SwiftTextStyles2  = Font.TextStyle.allCases.reduce(into: [String: Font.TextStyle]()) { $0["\($1)"] = $1 }

struct CVListModel: viewable {
    var content: [CVElement]?
    
    var style:          String?
    var header:         CVTextModel?
    var footer:         CVTextModel?
}


struct CVDefaultList: View {
    let model: CVListModel
    @Namespace var listAnimation

    var body: some View {
        let headerElement: CVElement = CVElement (from: model.header)
        let footerElement: CVElement = CVElement (from: model.footer)

        List {
            Section (
                header: headerElement.render(),
                footer: footerElement.render(),
                content: {
                    model.renderContent(namespace: listAnimation)
                }
            )
        }
        .listStyle (DefaultListStyle())
    }
}

struct CVPlainList: View {
    let model: CVListModel
    @Namespace var listAnimation

    var body: some View {
        let headerElement: CVElement = CVElement (from: model.header)
        let footerElement: CVElement = CVElement (from: model.footer)

        List {
            Section (
                header: headerElement.render(),
                footer: footerElement.render(),
                content: {
                    model.renderContent(namespace: listAnimation)
                }
            )
        }
        .listStyle (PlainListStyle())
    }
}


struct CVGroupedList: View {
    let model: CVListModel
    @Namespace var listAnimation

    var body: some View {
        let headerElement: CVElement = CVElement (from: model.header)
        let footerElement: CVElement = CVElement (from: model.footer)

        List {
            Section (
                header: headerElement.render(),
                footer: footerElement.render(),
                content: {
                    model.renderContent(namespace: listAnimation)
                }
            )
        }
        .listStyle (GroupedListStyle())
    }
}

struct CVInsetList: View {
    let model: CVListModel
    @Namespace var listAnimation

    var body: some View {
        let headerElement: CVElement = CVElement (from: model.header)
        let footerElement: CVElement = CVElement (from: model.footer)

        List {
            Section (
                header: headerElement.render(),
                footer: footerElement.render(),
                content: {
                    model.renderContent(namespace: listAnimation)
                }
            )
        }
        .listStyle (InsetListStyle())
    }
}


struct CVInsetGroupedList: View {
    let model: CVListModel
    @Namespace var listAnimation

    var body: some View {
        let headerElement: CVElement = CVElement (from: model.header)
        let footerElement: CVElement = CVElement (from: model.footer)

        List {
            Section (
                header: headerElement.render(),
                footer: footerElement.render(),
                content: {
                    model.renderContent(namespace: listAnimation)
                }
            )
        }
        .listStyle (InsetGroupedListStyle())
    }
}

struct CVSidebarList: View {
    let model: CVListModel
    @Namespace var listAnimation

    var body: some View {
        let headerElement: CVElement = CVElement (from: model.header)
        let footerElement: CVElement = CVElement (from: model.footer)

        List {
            Section (
                header: headerElement.render(),
                footer: footerElement.render(),
                content: {
                    model.renderContent(namespace: listAnimation)
                }
            )
        }
        .listStyle (SidebarListStyle())
    }
}
struct CVList: View {
    let model: CVListModel
    @Namespace var listAnimation

    var body: some View {
        let headerElement: CVElement = CVElement (from: model.header)
        let footerElement: CVElement = CVElement (from: model.footer)

        List {
            Section (
                header: headerElement.render(),
                footer: footerElement.render(),
                content: {
                    model.renderContent(namespace: listAnimation)
                }
            )
        }
        .listStyle (DefaultListStyle())
    }
}



struct ListViewDemo: View {
   
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


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
         ListViewDemo()
        //CVListView(model: CVListModel(from:""))
    }
}
