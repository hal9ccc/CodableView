//
//  NavigationLink.swift
//  CodableView
//
//  Created by Matthias Schulze on 14.11.20.

import SwiftUI
import SFSafeSymbols

struct CVNavigationLinkModel: viewable {
    var content:        [CVElement]?

    var text:                     String
    var navigationTitle:          String
    var destinationViewId:        String

    func autoId() -> String {
        let f = text > "" ?  text : String(describing: self)
        print ("autoId: \(f)")
        return f
    }
}

struct CVNavigationLink: View {
    let model: CVNavigationLinkModel

    @EnvironmentObject var cvCache : CVFirestore
   
    var body: some View {
        //let _: () = print("Label: '\(String(describing: model.text))'")
        //var renderingMode: TemplateRenderingMode = .original

        let vm = cvCache.viewModels[model.destinationViewId]

        NavigationLink ( destination: CVRootView ( vm: vm! )) {
            Text(model.text)
        }

    }
}


struct NavigationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextViewDemo()
        }
    }
}
