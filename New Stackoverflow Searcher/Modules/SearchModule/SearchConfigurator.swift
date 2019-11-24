//
//  SearchConfigurator.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import UIKit

//MARK: - Protocols
protocol SearchConfiguratorProtocol: class {
    func configure(with viewController: SearchViewController)
}

//MARK: - SearchConfigurator body
class SearchConfigurator: SearchConfiguratorProtocol {
    func configure(with viewController: SearchViewController) {
        let presenter = SearchPresenter(view: viewController)
        let interactor = SearchInteractor(presenter: presenter)
        let router = SearchRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
    
}

