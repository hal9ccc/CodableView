//
//  TextField.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 14.11.20.

import SwiftUI

struct CVTextFieldModel: Decodable {
    let text: String
    let value: String?
    let style: String?
    let disabled: String?

    var color:                  String? = ""
    var backgroundColor:        String? = ""
    var padding:                String? = ""

}


struct CVTextField: View {
    let model: CVTextFieldModel
    
    @State private var entry: String = ""

    var body: some View {
        
        let _: () = print("TextField:\(model.text)")

        TextField(model.text, text: $entry)
//            .frame(minWidth: 20, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
//            .padding(.leading)
//            .font(.system(size: 20))
            .onAppear(perform: { entry = model.value ?? "" })
            .padded(with: model.padding)
            .colored(with: model.color, backgroundColor: model.backgroundColor)

    }
}


struct CVTextFieldRoundedBorders: View {
    let model: CVTextFieldModel

    var body: some View {
        CVTextField(model: model)
            .textFieldStyle(RoundedBorderTextFieldStyle())

    }
}




struct TextfieldView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            CVTextField(model: CVTextFieldModel(text: "placeholder", value: "the value", style: "", disabled: ""))
        }
        .padding(.horizontal)
    }
}
