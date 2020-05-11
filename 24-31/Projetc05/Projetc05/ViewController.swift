//
//  ViewController.swift
//  Projetc05
//
//  Created by Rafael Dias on 10/05/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var words = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add '+' to ask for word
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(promptForAnswer)
        )
        
        // Load words from "start.txt" file
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordURL) {
                words = startWords.components(separatedBy: "\n")
            }
        }
        
        // If start.txt is empty, load "silkworm" for usage
        if words.isEmpty {
            words = ["silkworm"]
        }
        
        startGame()
    }
    
    func startGame() {
        title = words.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func submit(_ answer: String) {}
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    // TableView Configs
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)

        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }


}

