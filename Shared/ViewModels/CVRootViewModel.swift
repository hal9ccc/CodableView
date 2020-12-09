//
//  CVViewModel.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 12.11.20.
//  Copyright © 2020 Hacking with Swift. All rights reserved.
//

import Foundation
import SwiftUI

class CVRootViewModel: ObservableObject, Identifiable {
    
    @Published var id: String?
    @Published var title: String?

    @Published var element: CVElement?

    func load(element: CVElement, async: Bool = true) {
        
        print("\(String(describing: id)) loading \(element)")
        
        let element_with_guaranteed_ids = element.withGuaranteedId(baseId: id!)
        
        if async {
            DispatchQueue.main.async {
                withAnimation (.easeInOut) {
                    self.element = element_with_guaranteed_ids
                }
            }
        }
        else {
            withAnimation (.easeInOut) {
                self.element = element_with_guaranteed_ids
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
