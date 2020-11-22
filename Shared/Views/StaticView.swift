//
//  ContentView.swift
//  BackendDrivenUI
//
//  Created by Mohammad Azam on 10/13/20.
//

import SwiftUI

struct MyStaticView: View {
    
    var body: some View {
        TextViewDemo()
    }
}

class MyStaticViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let controller = UIHostingController(rootView: MyStaticView())
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

}


struct MyStaticView_Previews: PreviewProvider {
    static var previews: some View {
        MyStaticView()
    }
}
