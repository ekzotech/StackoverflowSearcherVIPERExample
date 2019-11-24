//
//  AnswerDetailConfigurator.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import Foundation

protocol AnswerDetailConfiguratorProtocol: class {
    func configure(with viewController: AnswerDetailViewController)
}

class AnswerDetailConfigurator: AnswerDetailConfiguratorProtocol {
    func configure(with viewController: AnswerDetailViewController) {
        
        let presenter = AnswerDetailPresenter(view: viewController)
        let interactor = AnswerDetailInteractor(presenter: presenter)
        let router = AnswerDetailRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
    
}
