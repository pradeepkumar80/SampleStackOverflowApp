//
//  SOQuestionsTableVC.swift
//  SampleAppSOAPI
//
//  Created by Pradeep on 2/5/21.
//

import UIKit

class SOQuestionsTableVC: UITableViewController {
    
    //Constants
    let queryService = SOQueryService()
    var queryResults: [SOQuestion] = []
    
    //Activity indicator
    var indicator = UIActivityIndicatorView()

    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show the activity indicator
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = .white
        
        //Invoke StackOverflow REST API GET Request
        queryService.getQuestions { [weak self] results, errorMessage in
          
            //Hide the activity indicator
            self?.indicator.stopAnimating()
            self?.indicator.hidesWhenStopped = true
            
            //If the results are valid
            if let results = results {
                self?.queryResults = results
                self?.tableView.reloadData()
            }
            
            //If any error from API inform the user
            if !errorMessage.isEmpty {
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queryResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SOQuestionTableViewCell = tableView.dequeueReusableCell(withIdentifier: SOQuestionTableViewCell.identifier, for: indexPath) as! SOQuestionTableViewCell

        // Configure the cell...
        let question = queryResults[indexPath.row]
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm"
        cell.lblCreationDate.text = df.string(from: question.creationDate)
        cell.lblQuestionTitle.text = question.title
        cell.lblAcceptedID.text = "Accepted AnswerID: " + String(question.acceptedID)
        cell.lblAnswersCount.text = "Answers: " + String(question.answers)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    

}
