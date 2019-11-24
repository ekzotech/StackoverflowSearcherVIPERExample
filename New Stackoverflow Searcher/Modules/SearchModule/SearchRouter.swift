//
//  SearchRouter.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import UIKit


protocol SearchRouterProtocol: class {
    func showAnswerDetailScene()
}

protocol SearchRouterDelegateProtocol {
    func performNavigationToAnswerDetail()
}

class SearchRouter: SearchRouterProtocol {
    
    weak var viewController: SearchViewController!
    
    init(viewController: SearchViewController) {
        self.viewController = viewController
    }
    
    func showAnswerDetailScene() {
        viewController?.performNavigationToAnswerDetail()
    }
    
}
