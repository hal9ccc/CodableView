//
//  KeypressAware.swift
//  CodableViewDemo
//
//  Created by Matthias Schulze on 15.12.20.
//

import UIKit
import SwiftUI

extension Notification.Name {
    static let enter = Notification.Name("enter")
    static let remove = Notification.Name("remove")
    static let submit = Notification.Name("submit")
}

class InputData: ObservableObject {

    var input: String = "abc"
   
}
    
    
class TypingController: UIViewController {

    override func viewDidLoad() {
        print("viewDidLoad-TypingController--------------------------------")
        super.viewDidLoad()
        let controller = UIHostingController(rootView: RootNavigationView(viewId: "Main")
//            RootNavigationView(viewId: "Main")
                .environmentObject(CVCache)
                .environmentObject(inputData)
        )
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(controller)
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            controller.view.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            controller.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        guard let key = presses.first?.key else { return }
        print("pressesBegan: \(key)")
        inputData.input.append(key.characters)
        print("input: \(inputData.input)")
        
        switch key.keyCode {
            case .keyboardDeleteOrBackspace:
                NotificationCenter.default.post(name: .remove, object: nil)
            case .keyboardReturn:
                NotificationCenter.default.post(name: .submit, object: nil)
            default:
                let characters = key.characters
                if let number = Int(characters) {
                    NotificationCenter.default.post(name: .enter, object: number)
                } else {
                    super.pressesBegan(presses, with: event)
                }
        }
    }
}



struct TypingView: UIViewControllerRepresentable {

    // 2.
    func makeUIViewController(context: Context) -> TypingController {
        print("makeUIViewController")
        return TypingController()
    }
    
    // 3.
    func updateUIViewController(_ uiViewController: TypingController, context: Context) {
        print("updateUIViewController")
    }
}
