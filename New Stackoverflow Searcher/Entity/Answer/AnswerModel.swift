//
//  AnswerModel.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import Foundation

struct AnswerModel {
    let owner: Owner
    let isAccepted: Bool
    let score: Int
    let lastActivityDate: Int
    let lastEditDate: Int?
    let creationDate: Int
    let answerId: Int
    let questionId: Int
    let body: String
}
