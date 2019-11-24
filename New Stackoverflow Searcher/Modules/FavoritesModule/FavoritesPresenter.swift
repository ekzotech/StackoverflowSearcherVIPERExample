//
//  FavoritesPresenter.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import UIKit

protocol FavoritesPresenterProtocol: class {
    var router: FavoritesRouterProtocol! { set get }
    func configureView()
    func getNumOfCells() -> Int
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func selectedAnswerAtIndex(tableView: UITableView, answerIndexPath: IndexPath)
    func favoritesUpdated()
    func showDetail()
    func searchInFavs(typedText: String)
    func updateTabBadge(count: Int)
}

class FavoritesPresenter {
    weak var view: FavoritesViewControllerProtocol!
    var interactor: FavoritesInteractorProtocol!
    var router: FavoritesRouterProtocol!
    
    required init(view: FavoritesViewControllerProtocol) {
        self.view = view
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    
    
    func configureView() {
        //
    }
    
    func getNumOfCells() -> Int {
        interactor.getFavoriteAnswersLength(filter: self.view.filterText)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let answer: AnswerModel = interactor.getAnswerByIndex(filter: self.view.filterText, index: indexPath.row)
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as? AnswerCell {
            cell.answerTitle.text = answer.body
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath)
            cell.textLabel?.text = answer.body
            return cell
        }
    }
    
    func selectedAnswerAtIndex(tableView: UITableView, answerIndexPath: IndexPath) {
        //        let answer = interactor.getAnswerByIndex(index: answerIndexPath.row)
        tableView.deselectRow(at: answerIndexPath, animated: true)
        interactor.openSelectedAnswer(filter: self.view.filterText, index: answerIndexPath.row)
        
    }
    
    func favoritesUpdated() {
        self.view.updateTableView()
    }
    
    func showDetail() {
        router?.showAnswerDetailScene()
    }
    
    func searchInFavs(typedText: String) {
        self.view.updateTableView()
    }
    
    func updateTabBadge(count: Int) {
        view.setFavoriteTabBadge(count: count)
    }
}
