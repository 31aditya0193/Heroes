//
//  ViewController.swift
//  Heroes
//
//  Created by Aditya on 09/04/22.
//

import UIKit

class HomveVC: UIViewController {
    @IBOutlet weak var heroesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var urlManager = URLManager()
        if let urlString = urlManager.getApiPath() {
            NetworkManager.shared.getApiData(requestUrl: urlString, completionHandler: {
                print("Call Successful")
            })
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
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath)
        cell.textLabel?.text = "Hello"
        return cell
    }
    
}

