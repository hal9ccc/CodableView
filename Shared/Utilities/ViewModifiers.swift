//
//  ViewModifiers.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 05.12.20.
//

import SwiftUI

/*
** ************************************************************************************************
*/

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

/*
** ************************************************************************************************
*/
struct Padding: ViewModifier {
    var padding: String?

    func body(content: Content) -> some View {

        let _padding_Side  =
            padding                          == nil ? nil                   :
            padding!.range(of: "top"       ) != nil ? Edge.Set.top          :
            padding!.range(of: "bottom"    ) != nil ? Edge.Set.bottom       :
            padding!.range(of: "leading"   ) != nil ? Edge.Set.leading      :
            padding!.range(of: "trailing"  ) != nil ? Edge.Set.trailing     :
            padding!.range(of: "vertical"  ) != nil ? Edge.Set.vertical     :
            padding!.range(of: "horizontal") != nil ? Edge.Set.horizontal   : Edge.Set.all

        let _padding_CGFloat = CGFloat (
            padding                          == nil ? 0                     :
            Int(padding!)                    == nil ? 0                     : CGFloat(Int(padding!)!))
        

        if _padding_CGFloat > 0 {
            return content.padding(Edge.Set.all, _padding_CGFloat)
        }
        if _padding_Side != nil && padding != nil && padding! != "0" {
            return content.padding(_padding_Side!)
        }
        return content.padding(Edge.Set.all, 0)
//        return content.padding(.leastNonzeroMagnitude)
//        return content
//            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

    }
}


extension View {
    func padded(with padding: String?) -> some View {
        self.modifier(Padding(padding: padding))
    }
}
