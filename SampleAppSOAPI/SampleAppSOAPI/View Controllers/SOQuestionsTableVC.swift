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
    private var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.backgroundColor = .white
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show the activity indicator
        indicator.center = view.center
        view.addSubview(indicator)

        //Invoke StackOverflow REST API GET Request
        queryService.getQuestions { [weak self] results, errorMessage in
          
            //Hide the activity indicator
            self?.indicator.stopAnimating()
            
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
        cell.configure(for: question)

        return cell
    }
    

}
