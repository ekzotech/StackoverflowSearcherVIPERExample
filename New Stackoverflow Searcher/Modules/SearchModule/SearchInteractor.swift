//
//  SearchInteractor.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import Foundation

protocol SearchInteractorProtocol: class {
    func getQuestionsLength() -> Int
    func getQuestionByIndex(index: Int) -> QuestionModel
    func fetchQuestions(question: String)
    func fetchAnswerById(answerId: Int)
}

class SearchInteractor: SearchInteractorProtocol {
    let baseURL = "https://api.stackexchange.com/2.2/"
    let accessToken = "&access_token=YOUR_ACCESS_TOKEN_GOES_HERE"
    
    weak var presenter: SearchPresenterProtocol!
    
    var questionsArray: [QuestionModel] = []
    var answersArray: [AnswerModel] = []
    
    required init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getQuestionsLength() -> Int {
        return questionsArray.count
    }
    
    func getQuestionByIndex(index: Int) -> QuestionModel {
        return questionsArray[index]
    }
    
    func fetchQuestions(question: String) {
        
        let urlString = "\(baseURL)search/advanced?order=desc&sort=activity&accepted=true&site=stackoverflow&body=\(question)\(accessToken)&filter=!9Z(-wzu0T"
        performRequest(with: urlString)
    }
    
    func fetchAnswerById(answerId: Int) {
        let urlString = "\(baseURL)answers/\(answerId)?order=desc&sort=activity&site=stackoverflow&filter=!9Z(-wzfpy"
        performRequestCompletion(with: urlString, completion: parseAnswer)
    }
    
    func parseAnswer(answerData: Data) -> Void {
        self.answersArray = parseAnswerJSON(answerData) ?? []
        self.finishedParsing()
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error ) in
                
                if error != nil {
                    // ошибка
                    return
                }
                
                if let safeData = data {
                    if let parsedQuestions = self.parseJSON(safeData) {
                        self.questionsArray = parsedQuestions
                        self.presenter.dataReceived()
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func performRequestCompletion(with urlString: String, completion: @escaping (Data) -> Void) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error ) in
                
                if error != nil {
                    // ошибка
                    return
                }
                
                if let safeData = data {
                    completion(safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ questionData: Data) -> [QuestionModel]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let decodedData = try decoder.decode(QuestionsDataArray.self, from: questionData)
            
            var questions: [QuestionModel] = []
            for questionData in decodedData.items {
                questions.append(QuestionModel(tags: questionData.tags, owner: questionData.owner, isAnswered: questionData.isAnswered, viewCount: questionData.viewCount, acceptedAnswerId: questionData.acceptedAnswerId, answerCount: questionData.answerCount, score: questionData.score, lastActivityDate: questionData.lastActivityDate, creationDate: questionData.creationDate, questionId: questionData.questionId, link: questionData.link, title: questionData.title))
            }
            
            return questions
            
        } catch {
            // ошибка
            print("Ошибка декодера")
            print(error)
            return nil
        }
    }
    
    func parseAnswerJSON(_ answerData: Data) -> [AnswerModel]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let decodedData = try decoder.decode(AnswersDataArray.self, from: answerData)
            
            var answers: [AnswerModel] = []
            for answerData in decodedData.items {
                answers.append(AnswerModel(owner: answerData.owner, isAccepted: answerData.isAccepted, score: answerData.score, lastActivityDate: answerData.lastActivityDate, lastEditDate: answerData.lastEditDate, creationDate: answerData.creationDate, answerId: answerData.answerId, questionId: answerData.questionId, body: answerData.body))
            }
            
            
            return answers
            
        } catch {
            print("Decode error: \(error)")
            return nil
        }
        
    }
    
    func finishedParsing() {
        if self.answersArray.count > 0 {
            App.shared.setCurrentAnswer(answer: self.answersArray[0])
            presenter.showDetail()
        }
    }
}
