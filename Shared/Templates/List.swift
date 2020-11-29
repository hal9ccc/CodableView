//
//  List.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 25.11.20.
//

import SwiftUI


let SwiftListStyles: [String: Any] = [
    "plain":            PlainListStyle(),
    "inset":            InsetListStyle(),
    "InsetGrouped":     InsetGroupedListStyle(),
    "grouped":          GroupedListStyle(),
//  "elliptical":       EllipticalListStyle
]

// Map Iterable Enum to Dictionary so the elements can be accessed by name
//let SwiftTextStyles2  = Font.TextStyle.allCases.reduce(into: [String: Font.TextStyle]()) { $0["\($1)"] = $1 }

struct CVListModel: viewable {
    var uniqueId: UUID
    
    var listStyle:      String?
    var _listStyle:     Any? = nil

    var content: [CVElement]? = nil
    
    enum ListModelCodingKeys: String, CodingKey {
        case style
        case content
    }
    
    init(from decoder: Decoder) throws {
        uniqueId      = UUID()

        let container = try decoder.container(keyedBy: ListModelCodingKeys.self)
        listStyle     = try container.decodeIfPresent(String.self, forKey: .style)  ?? ""
        _listStyle    = SwiftListStyles  [listStyle! ] ?? SwiftListStyles  ["plain"]!
        content       = try container.decodeIfPresent([CVElement].self, forKey: .content)  ?? [CVElement]()
    }

}


struct CVListView: View {
    let model: CVListModel
    @Namespace var listAnimation

    var body: some View {
        let _: () = print("List style: \(String(describing: model._listStyle))")
        let _: () = print("List contents: \(String(describing: model.content))")
        
        List {
            Section (
                header: Text("Section"),
                footer: Text("sfdf"),
                content: {
                    renderContent(content: model.content, namespace: listAnimation)
                }
            )
        }
        .listStyle (GroupedListStyle())
    }
}

//struct ListTemplate: CVElement {
//   
//    let id:     String?
//    let model:  CVListModel
//    
//    func render() -> AnyView {
//        return CVListView(model: model).toAnyView()
//    }
//}




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
