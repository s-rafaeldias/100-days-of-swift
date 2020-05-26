//
//  ViewController.swift
//  Day41-Challenge
//
//  Created by Rafael Dias on 23/05/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var wordToGuessLabel: UILabel!
    var guessWordButton: UIButton!
    var guessLetterButton: UIButton!
    var usedLettersLabel: UILabel!
    
    var usedLetters = [Character]()
    var wordToGuess = String()
    var wordToDisplay = String() {
        didSet {
            wordToGuessLabel.text = wordToDisplay
        }
    }
    var words = [String]()
    
    override func loadView() {
        view = UIView()
        
        wordToGuessLabel = UILabel()
        wordToGuessLabel.translatesAutoresizingMaskIntoConstraints = false
        wordToGuessLabel.textAlignment = .center
        wordToGuessLabel.text = "WORD TO GUESS"
        wordToGuessLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(wordToGuessLabel)
        
        usedLettersLabel = UILabel()
        usedLettersLabel.translatesAutoresizingMaskIntoConstraints = false
        usedLettersLabel.textAlignment = .center
        usedLettersLabel.text = "USED LETTERS:\n"
        usedLettersLabel.numberOfLines = 5
        usedLettersLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(usedLettersLabel)
        
        guessWordButton = UIButton(type: .system)
        guessWordButton.translatesAutoresizingMaskIntoConstraints = false
        guessWordButton.setTitle("Guess word", for: .normal)
        guessWordButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        guessWordButton.addTarget(self, action: #selector(guessWord), for: .touchUpInside)
        view.addSubview(guessWordButton)
        
        guessLetterButton = UIButton(type: .system)
        guessLetterButton.translatesAutoresizingMaskIntoConstraints = false
        guessLetterButton.setTitle("Guess letter", for: .normal)
        guessLetterButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        guessLetterButton.addTarget(self, action: #selector(guessLetter), for: .touchUpInside)
        view.addSubview(guessLetterButton)
        
        NSLayoutConstraint.activate([
            wordToGuessLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            wordToGuessLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            wordToGuessLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            wordToGuessLabel.heightAnchor.constraint(equalToConstant: 100),
            // Used words Label
            usedLettersLabel.topAnchor.constraint(equalTo: wordToGuessLabel.bottomAnchor),
            usedLettersLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            usedLettersLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            usedLettersLabel.heightAnchor.constraint(equalToConstant: 140),
            // Guess Word Button
            guessWordButton.topAnchor.constraint(equalTo: usedLettersLabel.bottomAnchor),
            guessWordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80),
            // Guess Letter Button
            guessLetterButton.topAnchor.constraint(equalTo: usedLettersLabel.bottomAnchor),
            guessLetterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80)
        ])
//        usedLettersLabel.backgroundColor = .cyan
//        wordToGuessLabel.backgroundColor = .green
//        guessLetterButton.backgroundColor = .yellow
//        guessWordButton.backgroundColor = .blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadGame()
    }
    
    func loadGame() {
        var word = ""
        
        if let fileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let fileWords = try? String(contentsOf: fileURL) {
                words = fileWords.components(separatedBy: "\n")
                words = words.dropLast()
            }
        }
        words.shuffle()
        wordToGuess = words[0].uppercased()
        
        for _ in words[0] {
            word += "?"
        }
        
        usedLetters.removeAll(keepingCapacity: true)
        usedLettersLabel.text = "USED LETTERS:\n"
        wordToDisplay = word.uppercased()
        print("Palavra do jogo eh \(wordToGuess)")
    }
    
    func endGame() {
        let ac = UIAlertController(title: "Well Done!", message: "You found the word \(wordToGuess.uppercased())", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Play Again", style: .default) {
            [weak self] _ in
            self!.loadGame()
        })
        present(ac, animated: true)
    }
    
    func wrongAnswer() {
        let ac = UIAlertController(title: "Sorry...", message: "Looks like you didn't know the answer", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Go back", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    @objc func guessWord() {
        let ac = UIAlertController(title: "You know the word??", message: "Let me see if you really know!", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Guess it", style: .default) {
            [weak self, weak ac] _ in
            // Clear input
            guard var input = ac?.textFields?[0].text else { return }
            input = input.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if input.uppercased() == self!.wordToGuess.uppercased() {
                self!.endGame()
            } else {
                self!.wrongAnswer()
            }
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        present(ac, animated: true)
    }

    @objc func guessLetter() {
        let ac = UIAlertController(
            title: "Which letter?",
            message: "Guess a letter",
            preferredStyle: .alert
        )
        
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Guess", style: .default) {
            [weak self, weak ac] _ in
            // Get the input and uppercased() it
            guard let guess = ac?.textFields?[0].text?.uppercased() else { return }
            // Get the first character
            let letter = Character(extendedGraphemeClusterLiteral: guess.first!)
            var indexes = [Int]()
                        
            if self!.wordToGuess.contains(letter) {
                // Get all indexes for the given letter
                for (index, l) in self!.wordToGuess.enumerated() {
                    if letter == l {
                        indexes.append(index)
                    }
                }
                // Replace all ocorrences of `letter` in `self.wordToDisplay`
                var newWordToDisplay = ""
                for (i, l) in self!.wordToDisplay.enumerated() {
                    newWordToDisplay += indexes.contains(i) ? String(letter) : String(l)
                }
                self!.wordToDisplay = newWordToDisplay
            } else {
                // Add the letter to usedLetters array only if letter is not part of `wordToGuess`
                self!.usedLetters.append(letter)
                self!.usedLettersLabel.text = "USED LETTERS:\n\(self!.usedLetters)"
            }
            
            if self!.wordToGuess == self!.wordToDisplay {
                self!.endGame()
            }
        })
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }

}

