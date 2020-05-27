//
//  Person.swift
//  Project10
//
//  Created by Rafael Dias on 26/05/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
