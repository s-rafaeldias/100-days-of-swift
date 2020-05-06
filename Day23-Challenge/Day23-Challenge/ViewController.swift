//
//  ViewController.swift
//  Day23-Challenge
//
//  Created by Rafael Dias on 04/05/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flag Info"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Load flags from Content
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let bundle_content = try! fm.contentsOfDirectory(atPath: path)
        
        for item in bundle_content {
            if item.hasSuffix(".jpg") {
                flags.append(item)
            }
        }
        flags.sort()
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        cell.textLabel?.text = imageText(flags[indexPath.row])
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "FlagDetail") as? FlagViewController {
            vc.flagName = flags[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
            
    func imageText(_ imageName: String) -> String {
        let text = imageName.split(separator: ".")[0]
        if text.count <= 3 {
            return text.uppercased()
        } else {
            return text.capitalized
        }
    }


}

