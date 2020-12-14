//
//  ContentView.swift
//  Shared
//
//  Created by Matthias Schulze on 20.11.20.
//

import SwiftUI
import CoreData
import CodeScanner

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var viewId: String

    @State private var input: String = ""
    
    @State private var isShowingScanner = false
    
    @State private var isShowingImagePicker = false
    @State private var inputImage: UIImage?

    // screenManager provides us with screen data and updates
    //
    //@ObservedObject var cvCache : CVFirestore
    @EnvironmentObject var cvCache : CVFirestore

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//
//    private var items: FetchedResults<Item>
    
    var body: some View {

        let _: () = print("building screen \(viewId)")
        
        // retrieve the current view model
        let vm1 = cvCache.viewModels[viewId]
        let vm2 = cvCache.viewModels["ListDemo"]
        let vm3 = cvCache.viewModels["ListDemo2"]
        

        NavigationView {

            if vm1 != nil {
                CVRootView(vm: vm1!)
                    .overlay (
                        Text("> \(input)")
                            .foregroundColor(.gray)
                            .font(.largeTitle)
                            .padding(),
                        
                        alignment: .bottomTrailing
                    )
//                    .navigationBarItems(
//                        trailing: Button(
//                            action: {
//                                print("pressed")
//                                self.isShowingScanner = true
//                            }
//                        ) {
//                              Image(systemName: "qrcode.viewfinder")
//                              Text("Scan")
//                          }
//                    )
                    .overlay(
                        HStack {
                       
                            Button(
                                action: {
                                    print("pressed")
                                    self.isShowingScanner = true
                                }
                            ) {
                                  Image(systemName: "qrcode.viewfinder")
                                  Text("Scan")
                              }

                            Button(
                                action: {
                                    print("pressed")
                                    self.isShowingImagePicker = true
                                }
                            ) {
                                  Image(systemName: "photo.on.rectangle")
                                  Text("Images")
                              }
                   
                        },
                        
                        alignment: .bottom
                    )
            }
            else {
                ProgressView()
            }

            if vm2 != nil {
                CVRootView(vm: vm2!)
            }
            else {
                ProgressView()
            }


        }
        .navigationBarTitleDisplayMode(.automatic)
        .sheet(isPresented: $isShowingScanner) {
            
            // Map Iterable Enum to Dictionary so the elements can be accessed by name
//            let allCodeTypes = AVMetadataObject.ObjectType.allCases.reduce(into: [String: AVMetadataObject.ObjectType]()) { $0["\($1)"] = $1 }

            CodeScannerView (
                codeTypes: [
                    .qr,
                    .dataMatrix,
                    .aztec,
                    .interleaved2of5,
                    .pdf417,
                    .code39,
                    .code128,
                    .code93,
                    .code39Mod43,
                    .itf14,
                    .ean8,
                    .ean13
                ],
                simulatedData: "Paul Hudson\npaul@hackingwithswift.com",
                completion: self.handleScan
            )
        }

        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(image: self.$inputImage)
        }
        .toolbar {

            Button(
                action: {
                    print("pressed")
                    self.isShowingScanner = true
                }
            ) {
                  Image(systemName: "qrcode.viewfinder")
                  Text("Scan")
              }

            Button(
                action: {
                    print("pressed")
                    self.isShowingImagePicker = true
                }
            ) {
                  Image(systemName: "photo.on.rectangle")
                  Text("Images")
              }


//            Button(action: addItem) {
//                Label("Add Item", systemImage: "plus")
//            }
        }
        
        let _: () = print("view built")
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        switch result {
        case .success(let code):
            print(code)
            self.input = code
            //let details = code.components(separatedBy: "\n")
        case .failure(let error):
            print("Scanning failed")
        }
    }
    
}



extension Notification.Name {
    static let enter = Notification.Name("enter")
    static let remove = Notification.Name("remove")
    static let submit = Notification.Name("submit")
}


class LoadingViewController: UIViewController {
    private lazy var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // We use a 0.5 second delay to not show an activity indicator
        // in case our data loads very quickly.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
}


struct KeypressRespondingView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        UIView()
    }

    func updateUIView(_ view: UIView, context: Context) {
        
    }
}


class TypingController: UIViewController {
    override func viewDidLoad() {
        print("viewDidLoad---------------------------------")
        super.viewDidLoad()
        let hostingController = UIHostingController(rootView: ContentView(viewId: "Main"))
        view.addSubview(hostingController.view)
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        guard let key = presses.first?.key else { return }
        print("pressesBegan: \(key)")
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


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewId: "TextDemo")
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

