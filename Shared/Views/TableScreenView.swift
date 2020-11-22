//
//  TableScreenView.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 28.07.20.
//

import SafariServices
import UIKit
import SwiftUI

struct TableScreenView: View {
    @ObservedObject var screenManager: CVCache
    var screenId: String

    var body: some View {
        let screen = screenManager.screens[screenId]!
        return CustomTableView(viewModel: TableScreenViewModel(screen: screen))
    }
}

class TableScreen: UITableViewController {
    @ObservedObject private var screenManager: CVCache
    @State var screenId: String
    
    init(screenManager: CVCache, screenId: String) {
        self.screenManager = screenManager
        self.screenId      = screenId
        super.init(style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func reloadData() {
        title = screenManager.screens[screenId]!.title
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = screenManager.screens[screenId]!.title

        if let button = screenManager.screens[screenId]!.rightButton {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: button.title, style: .plain, target: self, action: #selector(rightBarButtonTapped))
        }
    }

    @objc func rightBarButtonTapped() {
        guard let button = screenManager.screens[screenId]!.rightButton else { return }
        screenManager.execute(button.action, from: self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screenManager.screens[screenId]!.rows!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let row = screenManager.screens[screenId]!.rows![indexPath.row]
        cell.textLabel?.text = row.title
        
        if let action = row.action {
            cell.selectionStyle = .default

            if action.presentsNewScreen {
                cell.accessoryType = .disclosureIndicator
            } else {
                cell.accessoryType = .none
            }
        } else {
            cell.selectionStyle = .none
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = screenManager.screens[screenId]!.rows![indexPath.row]
        screenManager.execute(row.action, from: self)

        if row.action?.presentsNewScreen == false {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
