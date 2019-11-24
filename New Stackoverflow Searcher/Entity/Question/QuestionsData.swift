//
//  QuestionsData.swift
//  New Stackoverflow Searcher
//
//  Created by ekzotech on 23.11.2019.
//  Copyright © 2019 ekzotech. All rights reserved.
//

import Foundation

struct QuestionsDataArray: Codable {
    let items: [QuestionData]
}

struct QuestionData: Codable {
    let tags: [String]
    let owner: Owner
    let isAnswered: Bool
    let viewCount: Int
    let acceptedAnswerId: Int
    let answerCount: Int
    let score: Int
    let lastActivityDate: Int
    let creationDate: Int
    let questionId: Int
    let link: String
    let title: String
}

struct Owner: Codable {
    let reputation: Int?
    let userId: Int?
    let acceptRate: Int?
    let profileImage: String?
    let displayName: String?
    let link: String?
}
