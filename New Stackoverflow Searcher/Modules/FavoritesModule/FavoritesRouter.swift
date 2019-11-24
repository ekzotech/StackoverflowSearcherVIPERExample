//
//  FavoritesRouter.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import UIKit

protocol FavoritesRouterProtocol: class {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func showAnswerDetailScene()
}

class FavoritesRouter {
    weak var viewController: FavoritesViewController!
    
    init(viewController: FavoritesViewController) {
        self.viewController = viewController
    }
}

extension FavoritesRouter: FavoritesRouterProtocol {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
    }
    
    func showAnswerDetailScene() {
        viewController?.performNavigationToAnswerDetail()
    }
}

