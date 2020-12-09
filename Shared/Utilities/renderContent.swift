//
//  RenderContent.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 27.11.20.
//

import SwiftUI

func renderContent(content: [CVElement]?, namespace: Namespace.ID) -> AnyView {

    //let arr: Range<Int> = (content != nil) ? content!.indices : [].indices
    if content == nil { return ProgressView().toAnyView() }
    let _: () = print("Content \(String(describing: content))")

    return ForEach(content!, id: \.id) { element in
        element.render()
            .matchedGeometryEffect(id: element.id, in: namespace)
    }.toAnyView()
    
}
