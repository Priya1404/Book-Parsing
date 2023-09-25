//
//  BooksListingVC.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 22/09/23.
//

import UIKit

class BooksListingVC: UIViewController {
    
    //MARK: IBOutlets & Properties
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var appDescriptionTextView: UITextView!
    @IBOutlet weak var checkProcessedBooksButton: UIButton!
    @IBOutlet weak var bookListingTableView: UITableView!
    
    var booksListingVM = BooksListingVM()
    
    //MARK: ViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = booksListingVM.getAppTitle()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backgroundColor = UIColor.systemBrown
        
        setUpTableView()
        setUpViews()
        getParsedDataFromBook()
    }
    
    //MARK: Fileprivate methods
    fileprivate func setUpTableView() {
        bookListingTableView.dataSource = self
        bookListingTableView.delegate = self
        bookListingTableView.layer.borderWidth = 2
        bookListingTableView.layer.borderColor = UIColor.brown.cgColor
    }
    
    fileprivate func setUpViews() {
        
        headingLabel.text = booksListingVM.getHeadingText()
        
        checkProcessedBooksButton.setTitle(booksListingVM.getPastButtonTitle(), for: .normal)
        checkProcessedBooksButton.titleLabel?.textAlignment = .center
        
        appDescriptionTextView.isEditable = false
        appDescriptionTextView.text = booksListingVM.getDescription()
        appDescriptionTextView.layer.borderWidth = 5
        appDescriptionTextView.layer.borderColor = UIColor.gray.cgColor
    }
    
    fileprivate func getParsedDataFromBook() {
        let url = booksListingVM.getBookURL()
        self.view.showLoader()
        let _ = TextFileParserWorker().getFileData(url: url) { [weak self] (response, error) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.view.dismissloader()
                if error == nil {
                    self.booksListingVM.setBooksDataSource(books: response?.0 ?? [])
                    self.booksListingVM.setDescription(contentDescription: response?.1 ?? "")
                    self.appDescriptionTextView.text = self.booksListingVM.getDescription()
                    self.bookListingTableView.reloadData()
                } else {
                    let alert = UIAlertController(title: "Error", message: "Network Error", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    //MARK: IBActions
    @IBAction func openProcessedBooksData(_ sender: UIButton) {
        if let processedBooksVC = UIStoryboard(name: BookParsingConstants.StoryBoardIDs.ProcessedBooks, bundle: nil).instantiateViewController(withIdentifier: BookParsingConstants.ViewControllerIDs.ProcessedBooksVC) as? ProcessedBooksVC {
            self.navigationController?.pushViewController(processedBooksVC, animated: true)
        }
    }
}

//MARK: TableView Delegate Methods
extension BooksListingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksListingVM.getNumberOfBooks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookParsingConstants.CellIdentifierIDs.BooksListingCell, for: indexPath)
        cell.textLabel?.text = booksListingVM.getBookTitle(forIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let singleBookDataVC = UIStoryboard(name: BookParsingConstants.StoryBoardIDs.SingleBookData, bundle: nil).instantiateViewController(withIdentifier: BookParsingConstants.ViewControllerIDs.SingleBookDataVC) as? SingleBookDataVC {
            let bookObject = booksListingVM.getBook(forIndex: indexPath.row)
            singleBookDataVC.singleBookDataVM = SingleBookDataVM(bookObject: bookObject)
            self.navigationController?.pushViewController(singleBookDataVC, animated: true)
        }
    }
}
