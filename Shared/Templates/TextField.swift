//
//  TextField.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 14.11.20.

import SwiftUI

struct TextfieldModel: Decodable, CodableModel {
    let name: String
    let value: String
}

struct TextfieldView: View {
    let model: TextfieldModel
    //@Namespace var textfieldAnimation
    
    @State private var entry: String = ""

    var body: some View {

        HStack {
            Text("\(model.name)")
                .padding(.trailing)
            
            TextField("\(model.name)", text: $entry)
                .padding(.leading)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disabled(true)
                .font(.system(size: 20))
                .onAppear(perform: { entry = model.value })
        }
    }
}

struct TextfieldTemplate: UITemplate {
    let id:    String?
    let model: TextfieldModel
    
    func render() -> AnyView {
        TextfieldView(model: model).toAnyView()
    }
}

struct TextfieldView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
          TextfieldView(model: TextfieldModel(name: "Field name", value: "Field Value"))
        }
        .padding(.horizontal)
    }
}
