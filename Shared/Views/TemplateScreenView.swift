//
//  ContentView.swift
//  BackendDrivenUI
//
//  Created by Mohammad Azam on 10/13/20.
//

import SwiftUI

func buildFrom(json: String, async: Bool = false) -> AnyView {

    let jsonData    = json.data(using: .utf8)!
    let vm          = TemplateScreenViewModel()
    
    do {
        let screen = try JSONDecoder().decode(Screen.self, from: jsonData)
        vm.load(screen: screen, async: async)
        return TemplateView(vm:vm).toAnyView()
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
                    .padding()
            }
        }
        .padding()
        .toAnyView()
    }
      
 }


struct TemplateView: View {
    @ObservedObject var vm: TemplateScreenViewModel

    @Namespace var screenAnimation
    @Namespace var templateAnimation
    
    var body: some View {
        VStack {
            ForEach(vm.templates, id: \.id) { template in
                //Section {
                template.render()
                //    .transition(.scale)
                //}
                    .matchedGeometryEffect(id: template.id, in: screenAnimation)
            }

        .transition(.scale)

        }
        .matchedGeometryEffect(id: vm.screen?.id, in: screenAnimation)
        
        //Spacer ()
    }
    
}

class TemplateViewController: UIViewController {

    @State private var screenVM: TemplateScreenViewModel = TemplateScreenViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let controller = UIHostingController(rootView: TemplateView(vm: screenVM))
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(controller)
        self.view.addSubview(controller.view)
        self.title = screenVM.screen?.title
        controller.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            controller.view.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            controller.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

    }

    func present(screen: Screen) {
        self.screenVM.load(screen: screen, async: true)
    }
}


struct TemplateView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateView(vm: TemplateScreenViewModel())
    }
}
