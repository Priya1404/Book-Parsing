//
//  ProcessedBookTableViewCell.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 23/09/23.
//

import UIKit

class ProcessedBookTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var mostFrequentLabel: UILabel!
    @IBOutlet weak var frequentSevenLabel: UILabel!
    @IBOutlet weak var highestScoringLabel: UILabel!
    
    //MARK: ViewController Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCellDetails(dataModel: ProcessedBookModel) {
        bookTitleLabel.text = dataModel.title
        mostFrequentLabel.text = dataModel.mostFrequent
        frequentSevenLabel.text = dataModel.frequentSeven
        highestScoringLabel.text = dataModel.highestScoring
    }
}
