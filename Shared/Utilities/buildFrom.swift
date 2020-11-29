//
//  buildFrom.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 27.11.20.
//

import SwiftUI

func buildFrom(json: String, async: Bool = false) -> AnyView {

    let jsonData    = json.data(using: .utf8)!
    let vm          = CVViewModel(from: "root")
    
    do {
        let element = try JSONDecoder().decode(CVElement.self, from: jsonData)
        vm.load(element: element, async: async)
        return CVView(vm:vm).toAnyView()
    }
    catch {
        print(error)
        let s = "\(error)"
        return VStack {
            Text("an error")
                .font(.system(Font.TextStyle.headline))
                .padding()

            ScrollView (.horizontal) {
                Text("\(s)")
                    .font(.system(Font.TextStyle.body, design: Font.Design.monospaced))
                    .lineLimit(10)
                    .padding()
            }
        }
        .padding()
        .toAnyView()
    }
      
 }
