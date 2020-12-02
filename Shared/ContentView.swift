//
//  ContentView.swift
//  Shared
//
//  Created by Matthias Schulze on 20.11.20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var viewId: String

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
        let vm1 = cvCache.viewModels[viewId] ?? cvCache.viewModels["error"]
        let vm2 = cvCache.viewModels["LabelDemo"] ?? cvCache.viewModels["error"]
        
        NavigationView {

            if vm1 != nil {
                CVRootView(vm: vm1!)
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
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif

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
