//
//  Divider.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 05.12.20.
//

import SwiftUI

struct CVDividerModel: viewable {
    var content: [CVElement]?
}


struct CVDivider: View {
    let model: CVDividerModel
    @Namespace var DividerAnimation

    var body: some View {
        Divider()
    }
}

struct CVDividerDemo: View {
   
    var body: some View { buildFrom(json: """
        {
            "title": "Divider Preview",
            "content": [
                { "Divider": { "content": [ ] } }
            ]
        }
        """
        )
    }

}


struct CVDivider_Previews: PreviewProvider {
    static var previews: some View {
        CVDividerDemo()
    }
}
