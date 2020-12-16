//
//  CodableViewDemoApp.swift
//  Shared
//
//  Created by Matthias Schulze on 20.11.20.
//

import Foundation
import UIKit
import SwiftUI
import Firebase

let CVCache   = CVFirestore()
let inputData = InputData()

class AppDelegate: NSObject, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("FirebaseApp.configure()...")
        FirebaseApp.configure()

        print("CVCache.beginListening()...")
        CVCache.beginListening()
        
        return true
    }

}

@main
struct CodableViewDemoApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            TypingView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(CVCache)
                .environmentObject(inputData)
        }
    }
}
