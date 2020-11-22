//
//  ScreenManager.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 22.07.20.
//

import Foundation
import AVKit
import SafariServices
import UIKit
import Firebase

class ScreenManager: ObservableObject {

    let db = Firestore.firestore()

//  let navigationController: UINavigationController
    let errorScreen   = Screen (id: "error",   title: "error", type: "table", rows: [], items: [], rightButton: nil)

    var isInitialized = false;
    var screenId: String = "home"
    
    // Screen descriptions including id, type (table/template), model data
    @Published var screens: [String: Screen] = [String: Screen]()

    // Screen View Models
    @Published var screenVMs: [String: TemplateScreenViewModel] = [String: TemplateScreenViewModel]()

    // stores all the views controllers we've created
    //private var viewControllers: [String: UIViewController] = [String: UIViewController]()

//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }

    /*
    ** maps screens to views
    */
    func mapScreenToViewController (screen: Screen) -> UIViewController {
        if screen.type == "table" {
            return TableScreen(screenManager: self, screenId: screen.id)
        }
        else if screen.type == "templates" {
            let vc = TemplateViewController()
            vc.present(screen: screen)
            return vc
        }
        else {
            return TableScreen(screenManager: self, screenId: screen.id)
        }
    }
    

    /*
    ** Begins listening on screens
    */
    func beginListeningForScreens() {
        
        db.collection("screens").addSnapshotListener { querySnapshot, error in

            print("got \(querySnapshot?.documentChanges.count ?? 0) screen change(s)")
            
            querySnapshot?.documentChanges.forEach { diff in
                do {
                    let screen = try diff.document.data(as: Screen.self)

                    if (diff.type == .added && screen != nil) {
                        print("New: \(screen!.id)")
                        self.loadScreen(screen: screen!)
                    }

                    if (diff.type == .modified && screen != nil) {
                        print("Modified: \(screen!.id)")
                        self.loadScreen(screen: screen!)
                    }

                    if (diff.type == .removed) {
                        print("Removed: \(screen!.id)")
                        self.screens[screen!.id] = nil
                    }
                }
                catch {
                    print(error)
                }
            }
            
            self.afterUpdateProcessing()
            
        }
        
        print ("Listening for changes on /screens ...")
    }

    /*
    ** after all Screens have been updated
    */
    func afterUpdateProcessing() {
        print("sync complete")
    }
    

    /*
    ** loads an updated screen and creates its view model
    */
    func loadScreen (screen: Screen) {

        self.screens[screen.id] = screen

        var vm = self.screenVMs[screen.id]
        if vm == nil {
            vm = TemplateScreenViewModel()
            self.screenVMs[screen.id] = vm
        }

        vm?.load(screen: screen)
        
        print("loaded \(String(describing: vm))")
    }
    
//    func switchScreen (id: String) {
//
//        guard let screen = screens[id] else {
//            print("screen '\(id)' doesn't exist")
//            return
//        }
//        
//        // Navigate to new screen
//        print("navigate to \(id)")
//        let vc = self.mapScreenToViewController(screen: screen)
//        //navigationController.pushViewController(vc, animated: true)
//        //navigationController.viewControllers.append(vc)
//
//        // store the controller that was last responsible for this screen so it can be updated when
//        // the screen changes
//        //viewControllers[id] = vc
//        
//        self.screenId = id
//    }


    func execute(_ action: Action?, from viewController: UIViewController) {
        guard let action = action else { return }

        if let action = action as? AlertAction {
            let ac = UIAlertController(title: action.title, message: action.message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            viewController.present(ac, animated: true)
                
        } else if let action = action as? ShowWebsiteAction {
            let vc = SFSafariViewController(url: action.url)
            viewController.navigationController?.present(vc, animated: true)
            
        } else if let action = action as? ShowStaticViewAction {
            let vc = MyStaticViewController()
            viewController.navigationController?.present(vc, animated: true)
            
        } else if let action = action as? ShowScreenAction {
            //switchScreen(id: action.id)
            print("ShowScreenAction \(action.id) TODO")
           
        } else if let action = action as? PlayMovieAction {
            let player = AVPlayer(url: action.url)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            player.play()

            viewController.present(playerViewController, animated: true)

        } else if let action = action as? ShareAction {
            var items = [Any]()

            if let text = action.text { items.append(text) }
            if let url = action.url { items.append(url) }

            if items.isEmpty == false {
                let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
                viewController.present(ac, animated: true)
            }
        }
    }
}
