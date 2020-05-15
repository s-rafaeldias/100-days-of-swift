//
//  ViewController.swift
//  Day32-Challenge
//
//  Created by Rafael Dias on 14/05/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clear))
        
    }
    
    @objc func clear() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func insertItem(_ item: String) {
        shoppingList.append(item)
        
        let indexPath = IndexPath(row: tableView.numberOfRows(inSection: 0), section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Add item", message: "Which item to add?", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] _ in
            guard let text = ac?.textFields?[0].text else { return }
            self?.insertItem(text)
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
    }
    
}

