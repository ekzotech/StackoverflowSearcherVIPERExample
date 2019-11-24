//
//  FavoritesConfigurator.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import Foundation

protocol FavoritesConfiguratorProtocol: class {
    func configure(with viewController: FavoritesViewController)
}

class FavoritesConfigurator: FavoritesConfiguratorProtocol {
    func configure(with viewController: FavoritesViewController) {
        let presenter = FavoritesPresenter(view: viewController)
        let interactor = FavoritesInteractor(presenter: presenter)
        let router = FavoritesRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
