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
    
    // CVFirestore provides us with screen data and updates
    @EnvironmentObject var cvCache : CVFirestore

   
    var body: some View {
       
        TypingView()
            .environmentObject(CVCache)
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
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

