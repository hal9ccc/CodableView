//
//  CVViewModel.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 12.11.20.
//  Copyright © 2020 Hacking with Swift. All rights reserved.
//

import Foundation
import SwiftUI

class CVViewModel: ObservableObject {
    
    //@Published var content: [CVElement] = [CVElement]
    @Published var rootElement: CVElement?
    @Published var title: String?

    func load(element: CVElement, async: Bool = true) {
        
        if async {
            DispatchQueue.main.async {
                withAnimation (.easeInOut) {
                    self.rootElement = element
                }
            }
        }
        else {
            withAnimation (.easeInOut) {
                self.rootElement = element
            }
        }
    }


//        let arr: Range<Int> = (screen.items != nil) ? screen.items!.indices : [].indices
//
//        arr.forEach { i in
//            let item   = screen.items![i]
//
//            // generate an ID for animations (should always remain the same for each item)
//            let itemId = "\(screen.id).\(i)_\(item.itemType)"
//            print (itemId)

   

}
