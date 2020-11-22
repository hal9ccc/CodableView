//
//  RoundedImage.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 12.11.20.
//

import SwiftUI

struct RoundedImageModel: CodableModel {
    let title: String
    let imageURL: String
}

struct RoundedImageView: View {
    let model: RoundedImageModel
    var body: some View {
        URLImage(url: model.imageURL)
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .frame(height: 320)
            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
//            .transition(.opacity)
    }
}

struct RoundedImageTemplate: UITemplate {
    let id:    String?
    let model: RoundedImageModel
    
    func render() -> AnyView {
        return RoundedImageView(model: model).toAnyView()
    }
}


struct RoundedImageView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedImageView(model: RoundedImageModel(title: "Testbox", imageURL: "https://picsum.photos/320/320/?random"))
    }
}

