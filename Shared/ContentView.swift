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
                    .navigationBarItems(
                        trailing: Button(
                            action: {
                                print("pressed")
                                self.isShowingScanner = true
                            }
                        ) {
                              Image(systemName: "qrcode.viewfinder")
                              Text("Scan")
                          }
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

//        .toolbar {
//            #if os(iOS)
//            EditButton()
//            #endif
//
////            Button(action: addItem) {
////                Label("Add Item", systemImage: "plus")
////            }
//        }
        
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

