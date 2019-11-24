//
//  AnswerDetailPresenter.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import UIKit

protocol AnswerDetailPresenterProtocol: class {
    var router: AnswerDetailRouterProtocol! { set get }
    func configureView()
    func addToFavoritesButtonPressed()
}

class AnswerDetailPresenter: AnswerDetailPresenterProtocol {
    
    weak var view: AnswerDetailViewControllerProtocol!
    var interactor: AnswerDetailInteractorProtocol!
    var router: AnswerDetailRouterProtocol!
    private var isFavoriteObserver: NSObjectProtocol!
    
    required init(view: AnswerDetailViewController) {
        self.view = view
        
        isFavoriteObserver = NotificationCenter.default.addObserver(forName: .favoriteAnswersChanged, object: nil, queue: .main) { [weak self] notification in
            self?.changeFavButtonIcon()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(isFavoriteObserver!)
    }
    
    func configureView() {
        // подготовка view
        self.view.setAnswerLabelText(text: interactor.getCurrentQuestion().body)
        self.changeFavButtonIcon()
    }
    
    func addToFavoritesButtonPressed() {
        interactor.currentAnswerFavToggle()
        self.changeFavButtonIcon()
    }
    
    func changeFavButtonIcon() {
        let isFav = interactor.isCurrentAnswerInFavorites()
        if isFav {
            self.view.setFavoriteButtonImage(image: UIImage.init(systemName: "star.fill")!)
        } else {
            self.view.setFavoriteButtonImage(image: UIImage.init(systemName: "star")!)
        }
    }
    
}
