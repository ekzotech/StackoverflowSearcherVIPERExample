//
//  AnswerDetailRouter.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import Foundation

protocol AnswerDetailRouterProtocol: class {
    func closeCurrentViewController()
}

class AnswerDetailRouter: AnswerDetailRouterProtocol {
    
    weak var viewController: AnswerDetailViewController!
    
    init(viewController: AnswerDetailViewController) {
        self.viewController = viewController
    }
    
    
    func closeCurrentViewController() {}
    
}
