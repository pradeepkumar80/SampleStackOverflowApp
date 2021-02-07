//
//  SOQuestion.swift
//  SampleAppSOAPI
//
//  Created by Pradeep on 2/5/21.
//

import Foundation

//Class to hold a StackOverflow(SO) question
class SOQuestion: Codable {
    //Constants
    let title: String
    let answers: Int
    let acceptedID: Int?
    let creationDateTimeStamp: Double
    
    //Coding Keys
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case answers = "answer_count"
        case acceptedID = "accepted_answer_id"
        case creationDateTimeStamp = "creation_date"
    }
}
