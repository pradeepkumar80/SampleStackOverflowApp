//
//  SOQueryService.swift
//  SampleAppSOAPI
//
//  Created by Pradeep on 2/5/21.
//

import Foundation

//Service class for handling REST API calls
class SOQueryService {
    
    //Contants and Variables
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    var questions: [SOQuestion] = []
    
    //Type aliases
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([SOQuestion]?, String) -> Void
    
    //Method to send GET request to read questions StackOverflow API
    func getQuestions(completion: @escaping QueryResult) {
      dataTask?.cancel()

        guard let url = URL(string: "https://api.stackexchange.com/2.2/questions?order=desc&sort=month&site=stackoverflow&key=NpeHvXr9x6sWOc6ZIuHu0g((") else {
          return
        }

        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
          defer {
            self?.dataTask = nil
          }

          if let error = error {
            self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
          } else if
            let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode == 200 {
            
            self?.updateQuestions(data)

            DispatchQueue.main.async {
              completion(self?.questions, self?.errorMessage ?? "")
            }
          }
        }
        
        dataTask?.resume()
    }
    
    
    //Method to parse JSON data and add questions to array
    private func updateQuestions(_ data: Data) {
        var response: JSONDictionary?
        questions.removeAll()
      
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
      
        guard let array = response!["items"] as? [Any] else {
          errorMessage += "Dictionary does not contain items key\n"
          return
        }
      
        var index = 0
      
        for questionDictionary in array {
            if let questionDictionary = questionDictionary as? JSONDictionary {
                if let acceptedAnswerID = questionDictionary["accepted_answer_id"] as? Int {
                    if let answerCount = questionDictionary["answer_count"] as? Int {
                        if answerCount > 1 {
                            if let title = questionDictionary["title"] as? String,
                               let unixTimestamp = questionDictionary["creation_date"] as? Double{
                                print("Adding title:\(title), answerCount:\(answerCount), acceptedAnswerID:\(acceptedAnswerID)")
                                questions.append(SOQuestion(title: title, answers: answerCount, acceptedID: acceptedAnswerID, creationDate: Date(timeIntervalSince1970: unixTimestamp)))
                                index += 1
                            }
                        }
                    }
                }
            } else {
                errorMessage += "Problem parsing Dictionary\n"
            }
        }
    }
  
}
