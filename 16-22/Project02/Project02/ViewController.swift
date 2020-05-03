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
    
    func askQuestion() {
        Flag1.setImage(UIImage(named: countries[0]), for: .normal)
        Flag2.setImage(UIImage(named: countries[1]), for: .normal)
        Flag3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    func configFlagButton(_ button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
    }

}

