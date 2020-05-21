//
//  ViewController.swift
//  Project07
//
//  Created by Rafael Dias on 14/05/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(showCredits)
        )
        
        let filterDataButton = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(filterData)
        )
        
        let reloadDataButton = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(resetData)
        )
        
        navigationItem.setRightBarButtonItems([filterDataButton, reloadDataButton], animated: true)

        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
        
//        if navigationController?.tabBarItem.tag == 1 {
//            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
//        } else {
//            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
//        }
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            [weak self] in
//            if let url = URL(string: self!.urlString!) {
//                if let data = try? Data(contentsOf: url) {
//                    self?.parse(json: data)
//                    return
//                }
//            }
//            self?.showError()
//        }
    }
    
    @objc func fetchJSON() {
        var urlString: String
        
        if navigationController?.tabBarItem.tag == 1 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func resetData() {
        filteredPetitions = petitions
        tableView.reloadData()
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(
            title: "Credits",
            message: "The data comes from API",
            preferredStyle: .alert
        )
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(ac, animated: true)
    }
    
    @objc func filterData() {
        let ac = UIAlertController(title: "Filter data", message: "Filter title", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Ok", style: .default) {
            [weak self, weak ac] _ in
            if let textToFilter = ac?.textFields?[0].text {
                self!.filteredPetitions = self!.petitions.filter {
                    $0.title.contains(textToFilter)
                }
            }
            self?.tableView.reloadData()
            return
        })
        
        present(ac, animated: true)
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the petitions", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.performSelector(onMainThread: #selector(tableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

