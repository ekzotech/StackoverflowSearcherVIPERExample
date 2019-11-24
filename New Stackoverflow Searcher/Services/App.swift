//
//  App.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import Foundation

class App {
    static let shared = App()
    
    // after each change publishing notification for all subscribers
    var favoriteAnswers: [AnswerModel] = [] {
        didSet {
            NotificationCenter.default.post(name: .favoriteAnswersChanged, object: nil)
        }
    }
    
    var currentAnswer: AnswerModel? = nil {
        didSet {
            NotificationCenter.default.post(name: .currentAnswerChanged, object: nil)
        }
    }
    
    func getFavoriteAnswers() -> [AnswerModel] {
        return self.favoriteAnswers
    }
    
    func toggleAnswerFavorite(answer: AnswerModel) {
        if isAnswerFavorite(answerId: answer.answerId) {
            self.favoriteAnswers = self.favoriteAnswers.filter { $0.answerId != answer.answerId }
        } else {
            self.favoriteAnswers.append(answer)
        }
        
    }
    
    func isAnswerFavorite(answerId: Int) -> Bool {
        return self.favoriteAnswers.contains { $0.answerId == answerId }
    }
    
    func getCurrentAnswer() -> AnswerModel? {
        return self.currentAnswer
    }
    
    func setCurrentAnswer(answer: AnswerModel) {
        self.currentAnswer = answer
    }
    
    private init() {}
}

extension NSNotification.Name {
    static let favoriteAnswersChanged = NSNotification.Name(Bundle.main.bundleIdentifier! + ".favoriteAnswers")
    static let currentAnswerChanged = NSNotification.Name(Bundle.main.bundleIdentifier! + ".currentAnswer")
}
