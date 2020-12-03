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
}


struct CVList: View {
    let model: CVListModel
    @Namespace var listAnimation

    var body: some View {
        List {
            model.renderContent(namespace: listAnimation)
        }
    }
}


struct CVDefaultList: View {
    let model: CVListModel

    var body: some View {
        CVList(model: model)
        .listStyle (DefaultListStyle())
    }
}

struct CVPlainList: View {
    let model: CVListModel

    var body: some View {
        CVList(model: model)
        .listStyle (PlainListStyle())
    }
}


struct CVGroupedList: View {
    let model: CVListModel

    var body: some View {
        CVList(model: model)
        .listStyle (GroupedListStyle())
    }
}

struct CVInsetList: View {
    let model: CVListModel

    var body: some View {
        CVList(model: model)
        .listStyle (InsetListStyle())
    }
}


struct CVInsetGroupedList: View {
    let model: CVListModel

    var body: some View {
        CVList(model: model)
        .listStyle (InsetGroupedListStyle())
    }
}

struct CVSidebarList: View {
    let model: CVListModel

    var body: some View {
        CVList(model: model)
        .listStyle (SidebarListStyle())
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
