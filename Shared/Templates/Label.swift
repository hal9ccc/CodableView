//
//  Label.swift
//  CodableView
//
//  Created by Matthias Schulze on 14.11.20.

import SwiftUI
import SFSafeSymbols

struct CVLabelModel: viewable {
    var content:        [CVElement]?

    var text:           String
    var image:          String?
}

struct CVLabel: View {
    let model: CVLabelModel
    
    var body: some View {
        //let _: () = print("Label: '\(String(describing: model.text))'")
        //var renderingMode: TemplateRenderingMode = .original
        
        Label {
            Text("\(model.text)")
                .font(.body)
//                .foregroundColor(.primary)
        } icon: {
            Image(systemName: model.image!)
                .renderingMode(.original)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                //.clipShape(Circle())
            
        }

    }
}


struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextViewDemo()
        }
    }
}
