//
//  SearchPresenter.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import UIKit

protocol SearchPresenterProtocol: class {
    var router: SearchRouterProtocol! { set get }
    func configureView()
    func getNumOfCells() -> Int
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func searchPressed(question: String)
    func dataReceived()
    func selectedQuestionAtIndex(tableView: UITableView, questionIndexPath: IndexPath)
    func prepareForSegue(segue: UIStoryboardSegue)
    func showDetail()
}

class SearchPresenter: SearchPresenterProtocol {
    
    
    
    weak var view: SearchViewProtocol!
    var interactor: SearchInteractorProtocol!
    var router: SearchRouterProtocol!
    
    required init(view: SearchViewController) {
        self.view = view
    }
    
    func configureView() {
        // настраиваем вьюху
    }
    
    func getNumOfCells() -> Int {
        return interactor.getQuestionsLength()
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let question: QuestionModel = interactor.getQuestionByIndex(index: indexPath.row)
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as? QuestionCell {
            cell.questionTitle.text = question.title
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
            cell.textLabel?.text = question.title
            return cell
        }
        
    }
    
    func searchPressed(question: String) {
        interactor.fetchQuestions(question: question)
    }
    
    func dataReceived() {
        view?.updateTableView()
    }
    
    func selectedQuestionAtIndex(tableView: UITableView, questionIndexPath: IndexPath) {
        let question = interactor.getQuestionByIndex(index: questionIndexPath.row)
        tableView.deselectRow(at: questionIndexPath, animated: true)
        interactor.fetchAnswerById(answerId: question.acceptedAnswerId)
        
    }
    
    func showDetail() {
        router?.showAnswerDetailScene()
    }
    
    func prepareForSegue(segue: UIStoryboardSegue) {
        //        if segue.identifier == "SegueFromSearch" {}
    }
}

