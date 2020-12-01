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
//    var content: [CVElement]? { [CVElement]() }

    func renderContent(namespace: Namespace.ID) -> AnyView {
        if content!.count == 0 { return ProgressView().toAnyView() }

        let _: () = print("Content \(String(describing: content))")

        return ForEach(content!, id: \.id) { element in
            element.render()
                .matchedGeometryEffect(id: element.id, in: namespace)
        }.toAnyView()
        
    }

}






//protocol UITemplate {
//    var uniqueId: UUID { get }
//    func render() -> AnyView
//}
//
//extension UITemplate {
//    var id: String { "\(UUID())" }
//    var uniqueId: UUID { UUID() }
//}


struct CVElement: Identifiable, Decodable {
    var uniqueId:       UUID  { UUID() }

    var id:             String? = ""
    var title:          String? = ""
   
    var Error:          CVErrorModel? = nil

    var Text:           CVTextModel? = nil
    var Label:          CVLabelModel? = nil

    var ZStack:         CVZStackModel? = nil
    var VStack:         CVVStackModel? = nil
    var List:           CVListModel? = nil

    //var content: [CVElement]? = [CVElement]()


    // builds a view matching the first viewable
    // TODO: find indirect way to return the corrosponding view
    func render() -> AnyView {

        let data: viewable? = model()
        //print ("Model: \(String(describing: model()))");
        
        if Error        != nil { return CVError     (model: Error!      ).toAnyView() }
        if Text         != nil { return CVText      (model: Text!       ).toAnyView() }
        if Label        != nil { return CVLabel     (model: Label!      ).toAnyView() }
        if ZStack       != nil { return CVZStack    (model: ZStack!     ).toAnyView() }
        if VStack       != nil { return CVVStack    (model: VStack!     ).toAnyView() }
        if List         != nil { return CVList      (model: List!       ).toAnyView() }

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

}

