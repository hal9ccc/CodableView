//
//  Spacer.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 05.12.20.
//

import SwiftUI

struct CVSpacerModel: viewable {
    var content: [CVElement]?
}


struct CVSpacer: View {
    let model: CVSpacerModel
    @Namespace var SpacerAnimation

    var body: some View {
        Spacer()
    }
}

struct CVSpacerDemo: View {
   
    var body: some View { buildFrom(json: """
        {
            "title": "Spacer Preview",
            "content": [
                { "Spacer": { "content": [ ] } }
            ]
        }
        """
        )
    }

}


struct CVSpacer_Previews: PreviewProvider {
    static var previews: some View {
        CVSpacerDemo()
    }
}
