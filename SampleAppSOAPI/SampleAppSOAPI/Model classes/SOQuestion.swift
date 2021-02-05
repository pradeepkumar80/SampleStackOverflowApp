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
    let title: String
    let answers: Int
    let acceptedID: Int
    let creationDate: Date
    
    //Constructor
    init(title: String, answers: Int, acceptedID: Int, creationDate: Date) {
        self.title = title
        self.answers = answers
        self.acceptedID = acceptedID
        self.creationDate = creationDate
    }
}
