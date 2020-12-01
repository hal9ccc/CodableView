//
//  ContentView.swift
//  BackendDrivenUI
//
//  Created by Mohammad Azam on 10/13/20.
//

import SwiftUI


struct CVRootView: View {

    @ObservedObject var vm: CVRootViewModel
    
    @State private var isError = false
    @State private var error: Error?
    
    @Namespace var rootAnimation
    
    var body: some View {
        
        let title = vm.element?.title ?? vm.element?.id ?? ""
        
        ZStack {
            if vm.element == nil {
                ProgressView()
            }
            else {
                vm.element!.render()
            }
        }
        .matchedGeometryEffect(id: vm.element?.id, in: rootAnimation)
        .navigationTitle(title)
        .alert(isPresented: $isError) {
           Alert(title: Text(title),
                 message: Text("Try changing the name"),
                 dismissButton: .default(Text("OK")))
       }
    }
}

class TemplateViewController: UIViewController {

    @State private var vm: CVRootViewModel = CVRootViewModel(from: "Main")
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let controller = UIHostingController(rootView: CVRootView(vm: vm))
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(controller)
        self.view.addSubview(controller.view)
        self.title = vm.title ?? vm.element?.id ?? "title"
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
        CVRootView(vm: CVRootViewModel(from: "root"))
    }
}
