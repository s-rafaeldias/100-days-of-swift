//
//  DetailViewController.swift
//  Day59-Challenge
//
//  Created by Rafael Dias on 07/07/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    var country: Country!
    var sections: [[String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [
            ["Capital", country.capital],
            ["Region", country.region],
            ["Population", "\(country.population)"],
        ]
        
        title = country.name
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath)
        
        cell.textLabel?.text = sections[indexPath.section][1]
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section][0]
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count - 1
    }
}
