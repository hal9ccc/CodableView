//
//  TableScreen.swift
//  DeclarativeUI
//
//  Created by Paul Hudson on 03/03/2019.
//  Copyright © 2019 . All rights reserved.
//

import SafariServices
import UIKit
import SwiftUI

// generic table view model protocol
protocol CustomTableViewModel: UITableViewDataSource, UITableViewDelegate {
    func configure(tableView: UITableView)
}

// generic table view that depends only on generic view model
struct CustomTableView<ViewModel:ObservableObject & CustomTableViewModel>: UIViewRepresentable {
    @ObservedObject var viewModel: ViewModel

    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView()
        viewModel.configure(tableView: tableView)
        return tableView
    }

    func updateUIView(_ tableView: UITableView, context: Context) {
        tableView.reloadData()
    }
}


// view model for presenting a Screen as a UITableView
class TableScreenViewModel: NSObject, ObservableObject, CustomTableViewModel {
    let screen: Screen
    let cellIdentifier = "MyCell"
    
    var vc: UITableView?

    init(screen: Screen) {
        self.screen = screen
    }

    func configure(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.vc = tableView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { screen.rows!.count }

    func numberOfRows(in section: Int) -> Int { 1 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let row = screen.rows![indexPath.row]
        cell.textLabel?.text = row.title
        print("row.title \(row.title)")
        
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
}
