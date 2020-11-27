//
//  RenderContent.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 27.11.20.
//

import SwiftUI

func renderContent(content: [CVElement]?, namespace: Namespace.ID) -> AnyView {

    let arr: Range<Int> = (content != nil) ? content!.indices : [].indices
    
    return ForEach(arr) { i in
        content![i].render()
            .matchedGeometryEffect(id: content![i].id, in: namespace)
    }.toAnyView()
    
}
