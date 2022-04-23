//
//  ViewController.swift
//  Heroes
//
//  Created by Aditya on 09/04/22.
//

import UIKit

// MARK: Home
class HomeVC: UIViewController {
    var vm : ResponseModel? = nil
    let urlManager = URLManager()
    @IBOutlet weak var heroSearchBar: UISearchBar!
    @IBOutlet weak var heroesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTable()
    }
}

// MARK: Search
extension HomeVC: UISearchBarDelegate {
    func setupSearchBar() {
        heroSearchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let urlString = urlManager.getApiRequest(forSearchString: searchText) {
            NetworkManager.shared.getApiData(urlRequest: urlString, resultType: ResponseModel.self, completionHandler: { result in
                self.vm = result
                DispatchQueue.main.async {
                    self.heroesTableView.reloadData()
                }
            })
        } else {
            print("API Request Parsing Failure")
        }
    }
}

// MARK: TableView
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
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
        if let hero = vm?.data.results[indexPath.row] {
            cell.setupCell(forHero: hero)
        }
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

// MARK: Navigation
extension HomeVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == .heroDetailSegueIdentifier,
            let destination = segue.destination as? HeroDetailVC,
            let heroIndex = heroesTableView.indexPathForSelectedRow?.row
        {
            destination.hero = vm?.data.results[heroIndex]
        }
    }
}
