//
//  CodableViewDemoApp.swift
//  Shared
//
//  Created by Matthias Schulze on 20.11.20.
//

import SwiftUI
import Firebase

let screenManager = CVCache()

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("FirebaseApp.configure()...")
        FirebaseApp.configure()
        
        screenManager.beginListeningForScreens()
        
        return true
    }
}

@main
struct CodableViewDemoApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView(screenId: "SwiftUITest", cvCache: screenManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
