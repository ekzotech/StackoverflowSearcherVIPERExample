//
//  AnswerDetailInteractor.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import Foundation

protocol AnswerDetailInteractorProtocol: class {
    var currentAnswer: AnswerModel? { get }
    func getCurrentQuestion() -> AnswerModel
    func currentAnswerFavToggle()
    func isCurrentAnswerInFavorites() -> Bool
}

class AnswerDetailInteractor: AnswerDetailInteractorProtocol {
    
    weak var presenter: AnswerDetailPresenterProtocol!
    
    var currentAnswer: AnswerModel?
    
    
    
    func getCurrentQuestion() -> AnswerModel {
        self.currentAnswer = App.shared.getCurrentAnswer()
        return self.currentAnswer!
    }
    
    required init(presenter: AnswerDetailPresenterProtocol) {
        self.presenter = presenter
        
    }
    
    func currentAnswerFavToggle() {
        if let currentAnswer = self.currentAnswer {
            App.shared.toggleAnswerFavorite(answer: currentAnswer)
        }
    }
    
    func isCurrentAnswerInFavorites() -> Bool {
        if let currentAnswer = self.currentAnswer {
            return App.shared.isAnswerFavorite(answerId: currentAnswer.answerId)
        } else {
            return false
        }
    }
}
