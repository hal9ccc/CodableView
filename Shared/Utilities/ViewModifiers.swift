//
//  ViewModifiers.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 05.12.20.
//

import SwiftUI

let SwiftColors: [String: Color] = [
    "clear":        Color.clear,
    "black":        Color.black,
    "white":        Color.white,
    "gray":         Color.gray,
    "red":          Color.red,
    "green":        Color.green,
    "blue":         Color.blue,
    "orange":       Color.orange,
    "yellow":       Color.yellow,
    "pink":         Color.pink,
    "purple":       Color.purple,
    "primary":      Color.primary,
    "secondary":    Color.secondary
]

struct Colors: ViewModifier {
    var foregroundColor: String?;
    var backgroundColor: String?;

    func body(content: Content) -> some View {

        let _fore  = SwiftColors      [foregroundColor       ?? ""] ?? SwiftColors      ["primary"]!
        let _back  = SwiftColors      [backgroundColor       ?? ""] ?? SwiftColors      ["clear"]!

        return content
            .foregroundColor(_fore)
            .background(_back)
    }
}


extension View {
    func colored(with foregroundColor: String?, backgroundColor: String?) -> some View {
        self.modifier(Colors(foregroundColor: foregroundColor, backgroundColor: backgroundColor))
    }
}
