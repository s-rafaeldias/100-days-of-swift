//
//  ViewController.swift
//  Project10
//
//  Created by Rafael Dias on 25/05/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            print("Could not find a PersonCell")
            fatalError("Could not find a PersonCell")
        }
        return cell
    }
}

