//
//  FlagViewController.swift
//  Day23-Challenge
//
//  Created by Rafael Dias on 05/05/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

class FlagViewController: UIViewController {
    @IBOutlet var flagImageView: UIImageView!
    var flagName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareFlag)
        )
        
        if let image = flagName {
            print(image)
            flagImageView.image = UIImage(named: image)
            flagImageView.layer.borderColor = UIColor.lightGray.cgColor
            flagImageView.layer.borderWidth = 1
        } else {
            print("Error loading")
        }
    }
    
    @objc func shareFlag() {
        var itensToShare = [Any]()
        
        if let imageToShare = flagImageView.image?.jpegData(compressionQuality: 0.8) {
            itensToShare.append(imageToShare)
        }
        itensToShare += [flagName!]
        
        let vc = UIActivityViewController(activityItems: itensToShare, applicationActivities: [])
        present(vc, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
