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

}
