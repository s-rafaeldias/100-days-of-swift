//
//  Commom.swift
//  Day50-Challenge
//
//  Created by Rafael Dias on 28/06/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

class Commom: NSObject {

}
