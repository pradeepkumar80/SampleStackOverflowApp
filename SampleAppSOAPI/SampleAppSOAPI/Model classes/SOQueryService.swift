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
    
    var errorMessage = ""
    var questions: [SOQuestion] = []
    
    //Type aliases
    typealias QueryResult = ([SOQuestion]?, String) -> Void
    
    //Method to send GET request to StackOverflow API and then decode the JSON reponse
    func getQuestions(completion: @escaping QueryResult) {
        
        //Set the url to REST API
        guard let url = URL(string: "https://api.stackexchange.com/2.2/questions?order=desc&sort=month&site=stackoverflow&key=NpeHvXr9x6sWOc6ZIuHu0g((") else {
                return
            }

        //Prepare the GET request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        defaultSession.dataTask(with: request) { [weak self] data, response, error in
          //make sure no error
          if let error = error {
            self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
          } else if
            let data = data,
            let response = response as? HTTPURLResponse,
            response.statusCode == 200 {
            do {
                //decode the JSON response
                let decodedResponse = try JSONDecoder().decode(SOResponse.self, from: data)
                decodedResponse.questions.removeAll {$0.answers < 2 || $0.acceptedID == nil}
                self?.questions = decodedResponse.questions
            }
            catch let parseError as NSError {
                self?.errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            }

            //return the SOQuestions array to main thread
            DispatchQueue.main.async {
                completion(self?.questions, self?.errorMessage ?? "")
            }
          }
        }.resume()
    }
  
}
