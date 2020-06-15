//
//  SimpleSelectionMenu.swift
//  SimpleSelectionMenu
//
//  Created by Puneet Mahajan on 11/06/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import Foundation
import UIKit

public class SelectionController: UITableViewController {
    
    private var multipleSelection: Bool
    private var items: [String]
    private var screenTitle = ""
    private var selectedItems = [String]()
    
    public var singleResult: ((Int, String)->())?
    public var multipleResult : (([String])->())?
    
    static let CellId = "SelectedCell"
    
    public init(items: [String], multipleSelection: Bool, screenTitle: String = "") {
        
        // Initialize local variables
        self.multipleSelection = multipleSelection
        self.items = items
        self.screenTitle = screenTitle
        
        // call super init method
        super.init(style: .plain)
    }
    
    deinit {
        print("\(self) deallocated successfully")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- VC Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        self.setupTableView()
    }
    
    private func setupNavigationBar() {
        
        navigationItem.title = screenTitle
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func doneTapped() {
        
        if multipleSelection {
            
            // check if selected items is empty
            // if it is empty then don't pass data
            if !selectedItems.isEmpty {
                multipleResult?(selectedItems)
            }
            
        } else {
            
            if let item = self.selectedItems.first {
                
                // Find the index of selected item
                if let index = self.items.firstIndex(of: item) {
                    singleResult?(index, item)
                }
                
            }
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func setupTableView() {
        
        self.tableView.rowHeight = 50
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: SelectionController.CellId)
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.tableFooterView = UIView()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
}
// MARK:- UITableViewDataSource

extension SelectionController {
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionController.CellId, for: indexPath)
        
        cell.selectionStyle = .none
        //cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
}

//MARK:- UITableViewDelegate

extension SelectionController {
    
    public override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if !multipleSelection {
            
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .none
            }
        }
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if multipleSelection {
            
            if let cell = tableView.cellForRow(at: indexPath) {
                
                if cell.accessoryType == .checkmark {
                    
                    let item = items[indexPath.row]
                    
                    self.selectedItems.removeAll(where: {$0 == item})
                    
                    cell.accessoryType = .none
                } else {
                    self.selectedItems.append(items[indexPath.row])
                    
                    cell.accessoryType = .checkmark
                }
            }
            
        } else {
            
            if let cell = tableView.cellForRow(at: indexPath) {
                
                self.selectedItems.removeAll()
                self.selectedItems.append(items[indexPath.row])
                cell.accessoryType = .checkmark
            }
            
        }
        
    }
}
