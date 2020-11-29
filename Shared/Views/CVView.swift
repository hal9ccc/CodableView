//
//  ContentView.swift
//  BackendDrivenUI
//
//  Created by Mohammad Azam on 10/13/20.
//

import SwiftUI


struct CVView: View {
    @ObservedObject var vm: CVViewModel

    @Namespace var rootAnimation
    
    var body: some View {
        ZStack {
            renderContent(content: vm.element?.content, namespace: rootAnimation)
        }
        .matchedGeometryEffect(id: vm.element?.id, in: rootAnimation)
    }
}

class TemplateViewController: UIViewController {

    @State private var vm: CVViewModel = CVViewModel(from: "Main")
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let controller = UIHostingController(rootView: CVView(vm: vm))
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(controller)
        self.view.addSubview(controller.view)
        self.title = vm.title
        controller.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            controller.view.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            controller.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

    }

    func present(element: CVElement) {
        self.vm.load(element: element, async: true)
    }
}


struct TemplateView_Previews: PreviewProvider {
    static var previews: some View {
        CVView(vm: CVViewModel(from: "root"))
    }
}
