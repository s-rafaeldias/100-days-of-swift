//
//  Photo.swift
//  Day50-Challenge
//
//  Created by Rafael Dias on 27/06/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

class Photo: NSObject {
    var imageID: String
    var caption: String
    
    init(imageID: String, caption: String) {
        self.imageID = imageID
        self.caption = caption
    }
}
