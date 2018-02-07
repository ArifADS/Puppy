//
//  ViewController.swift
//  Puppy
//
//  Created by Arif De Sousa on 2/7/18.
//  Copyright © 2018 arifads. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var dataModel = [QueryResult]() {
        didSet{ self.tableView.reloadSections([0], with: .automatic) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        API.queryRecipe(q: "")
        .then{
            self.dataModel = $0
        }
    }
    
}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
        cell.model = dataModel[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataModel[indexPath.row]
        
        if let url = URL(string: model.href) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            present(vc, animated: true)
        }
        
    }
}

extension ViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        API.queryRecipe(q: searchText)
        .then{ self.dataModel = $0 }
        .catch{ print($0.localizedDescription) }
    }
}

