//
//  DetailViewController.swift
//  Day50-Challenge
//
//  Created by Rafael Dias on 28/06/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var photo: Photo!
    var image: UIImageView!
    
    override func loadView() {
        view = UIView()
    
        let photoPath = getDocumentsDirectory().appendingPathComponent(photo.imageID).path
        image = UIImageView(image: UIImage(contentsOfFile: photoPath))
        view.addSubview(image)

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
//            image.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
//            image.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
//            image.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = photo?.caption
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
