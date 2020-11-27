//
//  GradientBox.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 12.11.20.
//

import SwiftUI

struct GradientBoxModel: Decodable {
    let title: String
    let height: CGFloat
}

struct GradientBoxView: View {
    
    @Namespace var screenAnimation

    let model: GradientBoxModel
    var body: some View {

        HStack
        {
            if model.height < 100 {
                Image(systemName: "trash")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .transition(.slide)
                    .matchedGeometryEffect(id: "image", in: screenAnimation)
            }

            Rectangle ()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .frame(width: 300, height: model.height)
                .transition(.slide)
                .matchedGeometryEffect(id: "rect", in: screenAnimation)
            
            if model.height > 100 {
                Image(systemName: "trash")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .transition(.slide)
                    .matchedGeometryEffect(id: "image", in: screenAnimation)
            }
        }
        .matchedGeometryEffect(id: "button", in: screenAnimation)
//        .transition(.scale)
    }
}

//struct GradientBoxTemplate: CVElement {
//    let id:    String?
//    let model: GradientBoxModel
//    
//    func render() -> AnyView {
//        GradientBoxView(model: model).toAnyView()
//    }
//}


struct GradientBoxViewe_Previews: PreviewProvider {
    static var previews: some View {
        GradientBoxView(model: GradientBoxModel(title: "Testbox", height: 100))
    }
}

