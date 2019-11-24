//
//  AnswerDetailViewController.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import UIKit

protocol AnswerDetailViewControllerProtocol: class {
    func setAnswerLabelText(text: String)
    func setFavoriteButtonImage(image: UIImage)
}

class AnswerDetailViewController: UIViewController, AnswerDetailViewControllerProtocol {
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    var presenter: AnswerDetailPresenterProtocol!
    let configurator: AnswerDetailConfiguratorProtocol = AnswerDetailConfigurator()
    
    @IBAction func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        presenter.addToFavoritesButtonPressed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        answerLabel.text = "Загрузка"
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    func setAnswerLabelText(text: String) {
        let htmlData = NSString(string: text).data(using: String.Encoding.utf8.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        let attributedString = try! NSAttributedString(data: htmlData!,
                                                       options: options,
                                                       documentAttributes: nil)
        //        self.answerLabel.text = text
        self.answerLabel.attributedText = attributedString
    }
    
    func setFavoriteButtonImage(image: UIImage) {
        DispatchQueue.main.async {
            self.favoriteButton.image = image
        }
    }
    
    
}
