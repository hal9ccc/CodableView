//
//  Error.swift
//  CodableView
//
//  Created by Matthias Schulze on 14.11.20.

import SwiftUI


struct CVErrorModel: viewable {
    var content: [CVElement]?

    var text:       String
    var type:       String?
    var details:    String?
   
}


struct CVError: View {
    let model: CVErrorModel
    
    var body: some View {

        VStack {
            Label {
                Text("\(model.type ?? "error")")
                    .font(.body)
                    .foregroundColor(.accentColor)
            } icon: {
                Image(systemName: "xmark.octagon.fill")
                    .renderingMode(.original)
            }

            Text("\(model.text)")
                .font(.system(.body))
        }
    }
}


struct ErrorViewDemo: View {
   
    var body: some View { buildFrom(json: """
        {
            "title": "Error Preview",
            "Error": {
                "type":     "DecodingError",
                "text":     "Your friggin data was fucking malformed!",
                "details":  "Internal stuff that won't be helpful and will probably reveal implementation details."
            }
        }
        """
        )
    }

}


struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ErrorViewDemo()
        }
    }
}
