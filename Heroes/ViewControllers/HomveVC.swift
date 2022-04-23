//
//  ViewController.swift
//  Heroes
//
//  Created by Aditya on 09/04/22.
//

import UIKit

class HomveVC: UIViewController {
    var vm : ResponseModel? = nil
    @IBOutlet weak var heroSearchBar: UISearchBar!
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
        self.heroesTableView.register(UINib(nibName: "HeroTableCell", bundle: nil), forCellReuseIdentifier: "HeroCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm?.data.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! HeroTableCell
        let name = vm?.data.results[indexPath.row].name ?? "Name Not Received"
        let thumbNail = vm?.data.results[indexPath.row].thumbnail
        var thumbNailPath = (thumbNail?.path ?? "") + "." + (thumbNail?.thumbnailExtension ?? "")
        thumbNailPath = thumbNailPath.replacingOccurrences(of: "http", with: "https")
        cell.setupCell(name: name, withImage: thumbNailPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: .heroDetailSegueIdentifier, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat.heroTableRowHeight
    }
}

extension HomveVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == .heroDetailSegueIdentifier,
            let destination = segue.destination as? HeroDetailVC,
            let heroIndex = heroesTableView.indexPathForSelectedRow?.row
        {
            destination.hero = vm?.data.results[heroIndex]
        }
    }
}
