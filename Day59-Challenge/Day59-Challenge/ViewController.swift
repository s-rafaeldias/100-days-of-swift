//
//  ViewController.swift
//  Day59-Challenge
//
//  Created by Rafael Dias on 07/07/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var apiURL = URL(string: "https://restcountries.eu/rest/v2/all?fields=name;capital;region;subregion;population;flag")
    var countries = [Country]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load data from RESTCountries
        do {
            let data = try Data(contentsOf: apiURL!)
            self.countries = parseAPI(data)
            tableView.reloadData()
        } catch {
            print("\(error)")
        }
                
    }
    
    func parseAPI(_ json: Data) -> [Country] {
        let decoder = JSONDecoder()
        
        do {
            let data = try decoder.decode([Country].self, from: json)
            return data
        } catch {
            print("Error on parsing API: \(error)")
            return []
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.country = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
}

