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
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    @Namespace var rootAnimation
    
    var body: some View {
        
        let title = vm.element?.title ?? vm.element?.id ?? ""
        
        let _: () = print("CVRootView VM: \(vm.element)")
        
        Group {
            if vm.element == nil {
                ProgressView()
            }
            else {
                vm.element!.render()
            }
        }
//        .matchedGeometryEffect(id: vm.element?.id, in: rootAnimation)
        .navigationTitle(title)
        .alert(isPresented: $isError) {
           Alert ( title: Text(title),
                 message: Text("Try changing the name"),
                 dismissButton: .default(Text("OK"))
           )
       }
    }
}

struct TemplateView_Previews: PreviewProvider {
    static var previews: some View {
        CVRootView(vm: CVRootViewModel(from: "root"))
    }
}
