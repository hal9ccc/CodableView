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

    func contentWithGuaranteedId(baseId: String) -> [CVElement]? {
        if content == nil { return nil}
        return content!.enumerated().map { (index, element) in
            element.withGuaranteedId(baseId: baseId, idx: index)
        }
    }

    func renderContent() -> AnyView {
        if content!.count == 0 { return ProgressView().toAnyView() }
        return ForEach(content!, id: \.id) { element in
            element.render()
        }.toAnyView()
    }

    func renderContent(namespace: Namespace.ID) -> AnyView {
        if content!.count == 0 { return ProgressView().toAnyView() }

        return ForEach(content!, id: \.id) { element in
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
    var TextField:      CVTextFieldModel? = nil
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
    
    func withGuaranteedId(baseId: String, idx: Int = -1) -> CVElement {
        var f = self
       
        let modelType = "\(type(of: f.model()))"
            .replacingOccurrences(of: "CV",    with: "")
            .replacingOccurrences(of: "Model", with: "")
        
        if (f.id ?? "").isEmpty {
            f.id = baseId + "." + modelType + (idx >= 0 ? "-\(idx)" : "")
            print("generated id:" + f.id!)
        }
        
        if f.List       != nil { f.List!    .content = f.List!      .contentWithGuaranteedId(baseId: f.id ?? "") }
        if f.VStack     != nil { f.VStack!  .content = f.VStack!    .contentWithGuaranteedId(baseId: f.id ?? "") }
        if f.HStack     != nil { f.HStack!  .content = f.HStack!    .contentWithGuaranteedId(baseId: f.id ?? "") }
        if f.ZStack     != nil { f.ZStack!  .content = f.ZStack!    .contentWithGuaranteedId(baseId: f.id ?? "") }
        if f.Form       != nil { f.Form!    .content = f.Form!      .contentWithGuaranteedId(baseId: f.id ?? "") }
        if f.Section    != nil { f.Section! .content = f.Section!   .contentWithGuaranteedId(baseId: f.id ?? "") }

        return f
    }
    

    // builds a view matching the first viewable
    // TODO: find indirect way to return the corrosponding view
    func render() -> AnyView {

        let data: viewable? = model()
        print ("Model: \(String(describing: model()))");
        
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
        
        
        if      TextField   != nil && TextField!.style == "roundedBorders" { return CVTextFieldRoundedBorders    (model: TextField!        ).toAnyView() }
        else if TextField   != nil                                         { return CVTextField                  (model: TextField!        ).toAnyView() }
  
        if      List        != nil && List!.style      == "plain"          { return CVPlainList                  (model: List!             ).toAnyView() }
        else if List        != nil && List!.style      == "grouped"        { return CVGroupedList                (model: List!             ).toAnyView() }
        else if List        != nil && List!.style      == "inset"          { return CVInsetList                  (model: List!             ).toAnyView() }
        else if List        != nil && List!.style      == "insetGrouped"   { return CVInsetGroupedList           (model: List!             ).toAnyView() }
        else if List        != nil && List!.style      == "sidebar"        { return CVSidebarList                (model: List!             ).toAnyView() }
        else if List        != nil                                         { return CVDefaultList                (model: List!             ).toAnyView() }
        


        if model() == nil {
            return SwiftUI.Text("this element contains no data").toAnyView()
        }
        
        return SwiftUI.Text("no view for \( String(describing: data))").toAnyView()
    }
    

    // uses reflection to return the first property that conforms to our viewable protocol
    func model() -> viewable {
        let mirror = Mirror (reflecting: self)
//        var v: viewable?
        
        for child in mirror.children {
//            if child.value.
//            if child.value != nil {
//                print("child.label:    "+String(describing: child.label))
//                print("child.value:    "+String(describing: child.value))
//            }
//            print("child:    "+String(describing: child))
            
            if let f = child.value as? CVZStackModel  { return f }
            if let f = child.value as? CVHStackModel  { return f }
            if let f = child.value as? CVVStackModel  { return f }
            if let f = child.value as? CVFormModel    { return f }
            if let f = child.value as? CVListModel    { return f }
            if let f = child.value as? CVSectionModel { return f }
        }
        
        return CVTextModel(from: "no data")
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

