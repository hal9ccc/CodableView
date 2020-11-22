//
//  TemplateScreenViewModel.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 12.11.20.
//  Copyright © 2020 Hacking with Swift. All rights reserved.
//

import Foundation
import SwiftUI

class CVViewModel: ObservableObject {
    
    @Published var templates: [UITemplate] = []
    @Published var screen: Screen?
    
    func load(screen: Screen, async: Bool = true) {
        
        self.screen = screen
        
        var t: [UITemplate] = []
        
        let arr: Range<Int> = (screen.items != nil) ? screen.items!.indices : [].indices
        
        arr.forEach { i in
            let item   = screen.items![i]

            // generate an ID for animations (should always remain the same for each item)
            let itemId = "\(screen.id).\(i)_\(item.itemType)"
            print (itemId)
            
            switch item.itemType {
            case .text:          t.append(TextTemplate          (id: itemId, model: screen.items![i].data as! TextModel))
            case .textfield:     t.append(TextfieldTemplate     (id: itemId, model: screen.items![i].data as! TextfieldModel))
            case .chart:         t.append(ChartTemplate         (id: itemId, model: screen.items![i].data as! ChartModel))
            case .roundedImage:  t.append(RoundedImageTemplate  (id: itemId, model: screen.items![i].data as! RoundedImageModel))
            case .gradientBox:   t.append(GradientBoxTemplate   (id: itemId, model: screen.items![i].data as! GradientBoxModel))
            }
        }

        if async {
            DispatchQueue.main.async {
//                withAnimation () {
//                withAnimation (.easeInOut(duration: 3)) {
                withAnimation (.easeInOut) {
//                withAnimation (Animation.interpolatingSpring(stiffness: 150, damping: 20)) {
//                    print("async")
//                    let arr: Range<Int> = t.indices
//                    arr.forEach { i in
//
//                        if self.templates.indices.contains(i) {
//                            print("assigned \(t[i])")
//                            self.templates[i] = t[i]
//                        }
//                        else {
//                            print("appended \(t[i])")
//                            self.templates.append(t[i])
//                        }
//                    }
                    
                    self.templates = t
                }
            }
        }
        else {
//            withAnimation (.easeInOut(duration:3)) {
            withAnimation () {
                print("sync")
                self.templates = t
            }
        }
        
   }
    

}
