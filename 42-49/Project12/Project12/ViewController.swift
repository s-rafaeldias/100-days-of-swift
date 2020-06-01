//
//  ViewController.swift
//  Project12
//
//  Created by Rafael Dias on 31/05/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        defaults.set(25, forKey: "Age")
    }


}

