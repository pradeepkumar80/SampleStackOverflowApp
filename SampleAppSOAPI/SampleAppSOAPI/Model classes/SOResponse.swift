//
//  SOResponse.swift
//  SampleAppSOAPI
//
//  Created by Pradeep on 2/7/21.
//

import Foundation

//Class to hold the response array
class SOResponse: Codable {
    var questions: [SOQuestion]
    
    enum CodingKeys: String, CodingKey {
        case questions = "items"
    }
}

