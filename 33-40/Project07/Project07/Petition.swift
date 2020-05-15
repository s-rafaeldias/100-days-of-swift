//
//  Petition.swift
//  Project07
//
//  Created by Rafael Dias on 14/05/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
