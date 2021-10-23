//
//  HomeView.swift
//  ProductsApp
//
//  Created by Jorge Flores Carlos on 22/10/21.
//  
//

import Foundation
import UIKit

class HomeView: UIViewController {

    // MARK: Properties
    var presenter: HomePresenterProtocol?
    
    var tableView: UITableView = {
        let table = UITableView()
        table.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        table.isHidden = true
        return table
    }()
    
    var paginationNumber = 0
    var searchText = ""
    var isLoading = true
    
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var products: [Product] = []

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupSearchBar()
        setupTableView()
    }
    
    func setupSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Products"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    
    func reloadData() {
        self.tableView.reloadData()
        tableView.isHidden = false
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if(searchText != self.searchText) {
            self.searchText = searchText
            paginationNumber = 0
            self.presenter?.searchProduct(with: searchText, page: 0)
        }
        
    }
}

extension HomeView: HomeViewProtocol {
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func pushInitialDataToView(with products: [Product]) {
        self.products = products
        isLoading = false
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func pushAditionalDataToView(with products: [Product]) {
        for product in products {
            self.products.append(product)
        }
        isLoading = false
        self.reloadData()
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
}

extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell
            else {
            return UITableViewCell()
        }
        let product = products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
    
    
}

extension HomeView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let positionY = scrollView.contentOffset.y
        if !isLoading, positionY > (tableView.contentSize.height - 100 - scrollView.frame.size.height), products.count > 0 {
            paginationNumber += 1
            self.presenter?.searchProduct(with: searchText, page: paginationNumber)
            isLoading = true
        }
    }
}

extension HomeView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if(searchBar.text!.count > 0) {
            filterContentForSearchText(searchBar.text!)
        }
        
    }
}
