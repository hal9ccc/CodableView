//
//  Templates.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 12.11.20.
//

import Foundation
import SwiftUI

protocol viewable: Decodable {
    var uniqueId: UUID { get }
    var content: [CVElement]? { get set }
}

extension viewable {
    var uniqueId: UUID { UUID() }

    func autoId() -> String {
        let f = String(describing: self)
        print ("autoId::generic: \(f)")
        return f
    }

    func renderContent(namespace: Namespace.ID) -> AnyView {
        if content!.count == 0 { return ProgressView().toAnyView() }

//        let _: () = print("Content \(String(describing: content))")

        return ForEach(content!, id: \.id) { element in
//            let _: () = print("id \(element.id ?? "null")")
//            let _: () = print("autoId \(element.autoId())")
            element.render()
                .matchedGeometryEffect(id: element.id, in: namespace)
        }.toAnyView()
        
    }

}

struct CVElement: Identifiable, Decodable {
    var uniqueId:       UUID  { UUID() }

    var id:             String? = ""
    var title:          String? = ""
   
    var Error:          CVErrorModel? = nil

    var Text:           CVTextModel? = nil
    var Label:          CVLabelModel? = nil
    var NavigationLink: CVNavigationLinkModel? = nil

    var ZStack:         CVZStackModel? = nil
    var VStack:         CVVStackModel? = nil
    var HStack:         CVHStackModel? = nil

    var Section:        CVSectionModel? = nil
    var Form:           CVFormModel? = nil

    var List:           CVListModel? = nil

    var Divider:        CVDividerModel? = nil
    var Spacer:         CVSpacerModel? = nil
    
    
    func autoId() -> String {
        let f = id ?? model()?.autoId() ?? String(describing: self)
        print ("autoId(\(uniqueId)) \(f)");
        return f
    }

    //var content: [CVElement]? = [CVElement]()

    // builds a view matching the first viewable
    // TODO: find indirect way to return the corrosponding view
    func render() -> AnyView {

        let data: viewable? = model()
        //print ("Model: \(String(describing: model()))");
        
        if Error            != nil { return CVError            (model: Error!            ).toAnyView() }
        if Text             != nil { return CVText             (model: Text!             ).toAnyView() }
        if Label            != nil { return CVLabel            (model: Label!            ).toAnyView() }

        if NavigationLink   != nil { return CVNavigationLink   (model: NavigationLink!   ).toAnyView() }

        if ZStack           != nil { return CVZStack           (model: ZStack!           ).toAnyView() }
        if VStack           != nil { return CVVStack           (model: VStack!           ).toAnyView() }
        if HStack           != nil { return CVHStack           (model: HStack!           ).toAnyView() }
        
        if Section          != nil { return CVSection          (model: Section!          ).toAnyView() }
        if Form             != nil { return CVForm             (model: Form!             ).toAnyView() }

        if Divider          != nil { return CVDivider          (model: Divider!          ).toAnyView() }
        if Spacer           != nil { return CVSpacer           (model: Spacer!           ).toAnyView() }
        
        
        if      List != nil && List!.style == "plain"        { return CVPlainList              (model: List!             ).toAnyView() }
        else if List != nil && List!.style == "grouped"      { return CVGroupedList            (model: List!             ).toAnyView() }
        else if List != nil && List!.style == "inset"        { return CVInsetList              (model: List!             ).toAnyView() }
        else if List != nil && List!.style == "insetGrouped" { return CVInsetGroupedList       (model: List!             ).toAnyView() }
        else if List != nil && List!.style == "sidebar"      { return CVSidebarList            (model: List!             ).toAnyView() }
        else if List != nil                                  { return CVDefaultList            (model: List!             ).toAnyView() }
        


        if model() == nil {
            return SwiftUI.Text("this element contains no data").toAnyView()
        }
        
        return SwiftUI.Text("no view for \( String(describing: data))").toAnyView()
    }
    

    // uses reflection to return the first property that conforms to our viewable protocol
    func model() -> viewable? {
        let mirror = Mirror(reflecting: self)

        for child in mirror.children {
            if let viewable = child.value as? viewable {
                return viewable
            }
        }
        
        return nil
    }
    
    // creates a CVElement with an error message
    init(from err: Error, title: String?) {
        self.id     = "errorElement"
        self.title  = title
        self.Text   = CVTextModel(from: "Error: \(err) Description: \(err.localizedDescription)")
    }

    // creates a CVElement with a Text model
    init(from text: CVTextModel?) {
        self.id     = "textElement"
        self.Text   = text ?? CVTextModel(from:"")
    }

}

