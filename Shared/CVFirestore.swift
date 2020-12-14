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

class CVFirestore: ObservableObject {

    let db = Firestore.firestore()

    var isInitialized = false;
    var screenId: String = "TextDemo"
    
    // Element descriptions including id, type (table/template), model data
    @Published var elements: [String: CVElement] = [String: CVElement]()

    // Screen View Models
    @Published var viewModels: [String: CVRootViewModel] = [String: CVRootViewModel]()

    /*
    ** Begins listening on screens
    */
    func beginListening() {
        
        db.collection("views").addSnapshotListener { querySnapshot, error in

            print("got \(querySnapshot?.documentChanges.count ?? 0) screen change(s)")
            
            querySnapshot?.documentChanges.forEach { diff in

                let changed_doc_id = diff.document.documentID
                //print (changed_doc_id)

                do {

                    // deserialize JSON into an abstract CVElement
                    let element = try diff.document.data(as: CVElement.self)

                    if (diff.type == .added && element != nil) {
                        print("New: \(changed_doc_id)")
                        self.loadElement(element: element!, id: changed_doc_id)
                    }

                    if (diff.type == .modified && element != nil) {
                        print("Modified: \(changed_doc_id)")
                        self.loadElement(element: element!, id: changed_doc_id)
                    }

                    if (diff.type == .removed) {
                        print("Removed: \(changed_doc_id)")
                        self.elements[changed_doc_id] = nil
                    }
                }
                catch {
                    // fake an error element with the message
                    print(error)
                    let errorElement = CVElement (from: error, title: "\(changed_doc_id)")
                    self.elements[changed_doc_id] = errorElement
                    self.loadElement(element: errorElement, id: changed_doc_id)
                }
            }
            
            self.afterUpdateProcessing()
        }
        
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
    func loadElement (element: CVElement, id: String) {

        self.elements[id] = element

        var vm = self.viewModels[id]
        if vm == nil {
            vm = CVRootViewModel(from: id)
            self.viewModels[id] = vm
        }

        vm?.load(element: element)

    }


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
