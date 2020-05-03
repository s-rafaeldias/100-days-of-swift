//
//  ViewController.swift
//  Project02
//
//  Created by Rafael Dias on 01/05/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var Flag1: UIButton!
    @IBOutlet var Flag2: UIButton!
    @IBOutlet var Flag3: UIButton!
    
    var score = 0
    var correctAnswer = 0
    
    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco",
        "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        configFlagButton(Flag1)
        configFlagButton(Flag2)
        configFlagButton(Flag3)

        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        Flag1.setImage(UIImage(named: countries[0]), for: .normal)
        Flag2.setImage(UIImage(named: countries[1]), for: .normal)
        Flag3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
    }
    
    func configFlagButton(_ button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
        } else {
            title = "Wrong!"
            score -= 1
        }
        
        let ac = UIAlertController(
            title: title,
            message: "Your score is \(score)",
            preferredStyle: .alert
        )
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
}

