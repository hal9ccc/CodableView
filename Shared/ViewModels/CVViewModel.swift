//
//  CVViewModel.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 12.11.20.
//  Copyright © 2020 Hacking with Swift. All rights reserved.
//

import Foundation
import SwiftUI

class CVViewModel: ObservableObject, Identifiable {
    
    //@Published var content: [CVElement] = [CVElement]
    @Published var id: String?
    @Published var element: CVElement?
    @Published var title: String?

    func load(element: CVElement, async: Bool = true) {
        
        print("\(String(describing: id)) loading \(element)")
        
        if async {
            DispatchQueue.main.async {
                withAnimation (.easeInOut) {
                    self.element = element
                }
            }
        }
        else {
            withAnimation (.easeInOut) {
                self.element = element
            }
        }
    }

    init(from id: String) {
        self.id     = id
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
