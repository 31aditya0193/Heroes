//
//  ViewController.swift
//  Heroes
//
//  Created by Aditya on 09/04/22.
//

import UIKit

class HomveVC: UIViewController {
    var vm : ResponseModel? = nil
    @IBOutlet weak var heroesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlManager = URLManager()
        if let urlString = urlManager.getApiRequest() {
            NetworkManager.shared.getApiData(urlRequest: urlString, resultType: ResponseModel.self, completionHandler: { result in 
                self.vm = result
                DispatchQueue.main.async {
                    self.heroesTableView.reloadData()
                }
            })
        } else {
            print("API Request Parsing Failure")
        }
        setupTable()
    }
}

extension HomveVC: UITableViewDelegate, UITableViewDataSource {
    func setupTable() {
        self.heroesTableView.delegate = self
        self.heroesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm?.data.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath)
        cell.textLabel?.text = vm?.data.results[indexPath.row].name ?? "No Name"
        return cell
    }
}

