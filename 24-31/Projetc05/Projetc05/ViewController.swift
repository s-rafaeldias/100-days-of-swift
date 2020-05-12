//
//  ViewController.swift
//  Projetc05
//
//  Created by Rafael Dias on 10/05/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

struct Answer {
    var status: Bool
    var errorTitle: String?
    var errorMsg: String?
    
    init() {
        self.status = true
        self.errorTitle = nil
        self.errorMsg = nil
    }
    
    init(status: Bool, errorTitle: String?, errorMsg: String?) {
        self.status = status
        self.errorTitle = errorTitle
        self.errorMsg = errorMsg
    }
}

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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(startGame)
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
    
    @objc func startGame() {
        title = words.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func isPossible(word: String) -> Answer {
        var answer = Answer(
            status: false,
            errorTitle: "Word not possible",
            errorMsg: "You can't spell that word from \(title!.lowercased())"
        )
        
        guard var tempWord = title?.lowercased() else { return answer }

        // TODO: Review implementation
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return answer
            }
        }

        answer.status = true
        answer.errorMsg = nil
        answer.errorTitle = nil
        return answer
    }
    
    func isOriginal(word: String) -> Answer {
        let ans = Answer(
            status: false,
            errorTitle: "Word already used!",
            errorMsg: "Be more original!"
        )

        if  word.lowercased() == title?.lowercased() { return ans }
        
        let status = !usedWords.contains(word)
        
        if status { return Answer() }
        return ans
    }
    
    func isReal(word: String) -> Answer {
        let ans = Answer(
            status: false,
            errorTitle: "Word not recognizes",
            errorMsg: "You can't just make up words, you know!"
        )
        
        if word.count < 3 { return ans }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )
        
        let status = misspelledRange.location == NSNotFound
        if !status {
            return ans
        } else { return Answer() }
    }

    /// Add the `answer` to `usedWords` if  the `answer` is original, real and possible.
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        let original = isOriginal(word: lowerAnswer)
        let real = isReal(word: lowerAnswer)
        let possible = isPossible(word: lowerAnswer)
        
        if possible.status && real.status && original.status {
            usedWords.insert(answer.lowercased(), at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
            return
        } else {
            let ac = UIAlertController(
                title: possible.errorTitle ?? original.errorTitle ?? real.errorTitle!,
                message: possible.errorMsg ?? original.errorMsg ?? real.errorMsg!,
                preferredStyle: .alert
            )
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(ac, animated: true)
        }
    }
    
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

