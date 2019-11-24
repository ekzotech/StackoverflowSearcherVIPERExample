//
//  FavoritesInteractor.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import Foundation

protocol FavoritesInteractorProtocol: class {
    func getFavoriteAnswersLength(filter: String) -> Int
    func getAnswerByIndex(filter: String, index: Int) -> AnswerModel
    func openSelectedAnswer(filter: String, index: Int)
}

class FavoritesInteractor: FavoritesInteractorProtocol {
    var favoriteAnswers: [AnswerModel] = []
    
    weak var presenter: FavoritesPresenterProtocol!
    
    private var favoritesObserver: NSObjectProtocol!
    
    required init(presenter: FavoritesPresenterProtocol) {
        self.presenter = presenter
        self.favoriteAnswers = App.shared.getFavoriteAnswers()
        self.favoritesObserver = NotificationCenter.default.addObserver(forName: .favoriteAnswersChanged, object: nil, queue: .main) { [weak self] notification in
            // do something with globalVariable here
            self!.favoriteAnswers = App.shared.getFavoriteAnswers()
            self!.presenter.favoritesUpdated()
            self!.presenter.updateTabBadge(count: self?.favoriteAnswers.count ?? 0)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(favoritesObserver!)
    }
    
    func getFavoriteAnswersLength(filter: String) -> Int {
        if filter == "" {
            return self.favoriteAnswers.count
        } else {
            return self.favoriteAnswers.filter {$0.body.lowercased().contains(filter)}.count
        }
    }
    
    func getAnswerByIndex(filter: String, index: Int) -> AnswerModel {
        if filter == "" {
            return self.favoriteAnswers[index]
        } else {
            return self.favoriteAnswers.filter {$0.body.lowercased().contains(filter)}[index]
        }
    }
    
    func openSelectedAnswer(filter: String, index: Int) {
        if filter == "" {
            App.shared.setCurrentAnswer(answer: self.favoriteAnswers[index])
        } else {
            App.shared.setCurrentAnswer(answer: self.favoriteAnswers.filter {$0.body.lowercased().contains(filter)}[index])
        }
        presenter.showDetail()
    }
}
