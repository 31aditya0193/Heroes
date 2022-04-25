//
//  ViewController.swift
//  Heroes
//
//  Created by Aditya on 09/04/22.
//

import UIKit

// MARK: Home
class HomeVC: UIViewController {
    var HomeViewModel : MvlResponseModel? = nil
    let urlManager = MvlURLManager()
    @IBOutlet weak var heroesTableView: UITableView!
    lazy var heroSearchBar: UISearchController = {
       let searchBar = UISearchController()
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getTableData(query: "")
    }
}

// MARK: Search
extension HomeVC: UISearchBarDelegate, UISearchResultsUpdating {
    func setupSearchBar() {
        navigationItem.searchController = heroSearchBar
        heroSearchBar.searchResultsUpdater = self
        heroSearchBar.searchBar.delegate = self
        heroSearchBar.searchBar.placeholder = "Summon Your Hero"
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            getTableData(query: searchText)
        }
    }
}

// MARK: TableView
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func setupTable() {
        self.heroesTableView.delegate = self
        self.heroesTableView.dataSource = self
        self.heroesTableView.register(UINib(nibName: String.heroTableCellNibName, bundle: nil), forCellReuseIdentifier: String.heroTableCellID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HomeViewModel?.data.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.heroTableCellID, for: indexPath) as! HeroTableCell
        if let hero = HomeViewModel?.data.results[indexPath.row] {
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
    
    func getTableData(query searchText: String) {
        if let urlRequest = urlManager.prepareUrlRequest(toSearch: searchText) {
            MvlNetworkManager.shared.getData(with: urlRequest, resultType: MvlResponseModel.self, completionHandler: { result in
                self.HomeViewModel = result
                DispatchQueue.main.async {
                    self.heroesTableView.reloadData()
                }
            })
        } else {
            print("API Request Parsing Failure")
        }
    }
}

// MARK: Navigation
extension HomeVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == .heroDetailSegueIdentifier,
            let destination = segue.destination as? HeroDetailVC,
            let heroIndex = heroesTableView.indexPathForSelectedRow?.row
        {
            destination.hero = HomeViewModel?.data.results[heroIndex]
        }
    }
}
