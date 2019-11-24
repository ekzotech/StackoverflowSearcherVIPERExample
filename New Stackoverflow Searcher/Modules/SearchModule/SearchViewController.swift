//
//  SearchViewController.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import UIKit

protocol SearchViewProtocol: class {
    func updateTableView()
    func performNavigationToAnswerDetail()
}

class SearchViewController: UITableViewController, SearchViewProtocol, UISearchBarDelegate {
    
    var presenter: SearchPresenterProtocol!
    let configurator: SearchConfiguratorProtocol = SearchConfigurator()
    
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var searchTextField: UISearchBar!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.navigationItem.title = "Search"
        configurator.configure(with: self)
        presenter.configureView()
        
        searchTextField.delegate = self // !!!
        
        // КОСТЫЛЬ!
        for viewController in tabBarController?.viewControllers ?? [] {
            if let navigationVC = viewController as? UINavigationController, let rootVC = navigationVC.viewControllers.first {
                let _ = rootVC.view
            } else {
                let _ = viewController.view
            }
        }
        
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
        presenter.selectedQuestionAtIndex(tableView: tableView, questionIndexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter.getCell(tableView: tableView, indexPath: indexPath)
    }
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func performNavigationToAnswerDetail() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "SegueFromSearch", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepareForSegue(segue: segue)
    }
    
    //MARK: - Searchbar
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        } else {
            searchBar.placeholder = "Type in your question!"
            return false
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let question = searchBar.text {
            presenter.searchPressed(question: question)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            searchBar.endEditing(true)
        } else {
            searchBar.endEditing(false)
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
