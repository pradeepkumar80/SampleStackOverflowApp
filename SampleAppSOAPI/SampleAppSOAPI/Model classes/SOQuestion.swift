//
//  SOQuestion.swift
//  SampleAppSOAPI
//
//  Created by Pradeep on 2/5/21.
//

import Foundation

//Class to hold a StackOverflow(SO) question
class SOQuestion {
    //Constants
    let question: String
    let answers: Int
    let acceptedID: Int
    let creationDate: Date
    
    //Constructor
    init(question: String, answers: Int, acceptedID: Int, creationDate: Date) {
        self.question = question
        self.answers = answers
        self.acceptedID = acceptedID
        self.creationDate = creationDate
    }
}
