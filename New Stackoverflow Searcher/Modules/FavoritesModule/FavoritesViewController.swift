//
//  FavoritesViewController.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import UIKit

protocol FavoritesViewControllerProtocol: class {
    var filterText: String { get }
    func updateTableView()
    func performNavigationToAnswerDetail()
    func setFavoriteTabBadge(count: Int)
}

class FavoritesViewController: UITableViewController, FavoritesViewControllerProtocol, UISearchBarDelegate {
    
    var presenter: FavoritesPresenterProtocol!
    let configurator: FavoritesConfiguratorProtocol = FavoritesConfigurator()
    
    var filterText: String = ""
    
    @IBOutlet weak var searchFavTextField: UISearchBar!
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationItem.title = "Favorites"
        configurator.configure(with: self)
        presenter.configureView()
        searchFavTextField.delegate = self // !!!
    }
    
    // MARK: - Table view data source
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getNumOfCells()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        performSegue(withIdentifier: "SegueFromFavorites", sender: self)
        presenter.selectedAnswerAtIndex(tableView: tableView, answerIndexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter.getCell(tableView: tableView, indexPath: indexPath)
    }
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.favoritesTableView.reloadData()
        }
    }
    
    func performNavigationToAnswerDetail() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "SegueFromFavorites", sender: self)
        }
    }
    
    //MARK: - Searchbar
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterText = searchText.lowercased()
        presenter.searchInFavs(typedText: self.filterText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            searchBar.endEditing(true)
        } else {
            searchBar.endEditing(false)
        }
        
    }
    
    //MARK: - TabBadge
    
    func setFavoriteTabBadge(count: Int) {
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[1]
            if count > 0 {
                tabItem.badgeValue = "\(count)"
            } else {
                tabItem.badgeValue = nil
            }
            
        }
    }
    
    //MARK: - Hiding Tabbar
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        
        if targetContentOffset.pointee.y < scrollView.contentOffset.y {
            // it's going up
            self.changeTabBar(hidden: false, animated: true)
        } else {
            // it's going down
            self.changeTabBar(hidden: true, animated: true)
        }
        
    }
    
    func changeTabBar(hidden:Bool, animated: Bool){
        guard let tabBar = self.tabBarController?.tabBar else { return; }
        if tabBar.isHidden == hidden{ return }
        let frame = tabBar.frame
        let offset = hidden ? frame.size.height : -frame.size.height
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        tabBar.isHidden = false

        UIView.animate(withDuration: duration, animations: {
            tabBar.frame = frame.offsetBy(dx: 0, dy: offset)
        }, completion: { (true) in
            tabBar.isHidden = hidden
        })
    }
}
