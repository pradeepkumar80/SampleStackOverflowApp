//
//  SOQuestionTableViewCell.swift
//  SampleAppSOAPI
//
//  Created by Pradeep on 2/5/21.
//

import UIKit

class SOQuestionTableViewCell: UITableViewCell {
    
    static let identifier = "SOQuestionCell"
    
    @IBOutlet weak var lblCreationDate: UILabel!
    @IBOutlet weak var lblQuestionTitle: UILabel!
    @IBOutlet weak var lblAnswersCount: UILabel!
    @IBOutlet weak var lblAcceptedID: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(for question: SOQuestion) {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm"
        let creationDate = Date(timeIntervalSince1970: question.creationDateTimeStamp)

        lblCreationDate.text = df.string(from: creationDate)
        lblQuestionTitle.text = question.title
        lblAcceptedID.text = "Accepted AnswerID: " + String(question.acceptedID ?? 0)
        lblAnswersCount.text = "Answers: " + String(question.answers)
    }

}
