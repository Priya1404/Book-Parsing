//
//  ProcessedBooksVCViewController.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 23/09/23.
//

import UIKit

class ProcessedBooksVC: UIViewController {

    //MARK: IBOutlets & Properties
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var processedBooksListingTableView: UITableView!
    
    var processedBookVM: ProcessedBooksVM? = ProcessedBooksVM()
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = processedBookVM?.getTitle()
        descriptionLabel.text = processedBookVM?.getDescriptionText()
        setUpTableView()
    }
    
    //MARK: Fileprivate methods
    fileprivate func setUpTableView() {
        processedBooksListingTableView.dataSource = self
        processedBooksListingTableView.delegate = self
    }
}

//MARK: Tableview Delegate methods
extension ProcessedBooksVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return processedBookVM?.getNumberOfProcessedBooks() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: BookParsingConstants.CellIdentifierIDs.ProcessedBookCell, for: indexPath) as? ProcessedBookTableViewCell {
            let processedBookData = processedBookVM?.getProcessedBookData(at: indexPath.row) ?? ("", [""], [""], [""])
            let dataModel = ProcessedBookModel(title: processedBookVM?.getBookTitleText(title: processedBookData.0) ?? NSAttributedString(),
                                               mostFrequent: processedBookVM?.getMostFrequentText(mostFrequent: processedBookData.1) ?? NSAttributedString(),
                                               frequentSeven: processedBookVM?.getFrequentSevenText(frequentSeven: processedBookData.2) ?? NSAttributedString(),
                                               highestScoring: processedBookVM?.getHighestScoringText(highestScoring: processedBookData.3) ?? NSAttributedString())
            cell.setUpCellDetails(dataModel: dataModel)
            cell.layer.borderWidth = 5
            cell.layer.borderColor = UIColor.brown.cgColor
            return cell
        }
        return UITableViewCell()
    }
}
