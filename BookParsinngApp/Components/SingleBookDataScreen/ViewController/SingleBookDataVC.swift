//
//  SingleBookDataVC.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 23/09/23.
//

import UIKit

class SingleBookDataVC: UIViewController {
    
    //MARK: IBOutletsn & Properties
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var bookContentTextView: UITextView!
    @IBOutlet weak var bookInfoButton: UIButton!
    
    var singleBookDataVM: SingleBookDataVM?
    
    //MARK: ViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = singleBookDataVM?.getTitle()
        bookDescriptionLabel.text = singleBookDataVM?.getDescriptionLabel()
        bookContentTextView.text = singleBookDataVM?.getBookContent()
        bookInfoButton.setTitle(singleBookDataVM?.getButtonTitle(), for: .normal)
        bookContentTextView.isEditable = false
        bookContentTextView.layer.borderWidth = 5
        bookContentTextView.layer.borderColor = UIColor.gray.cgColor
    }
    
    //MARK: IBActions
    @IBAction func checkBookInfoClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: singleBookDataVM?.getButtonTitle(), message: singleBookDataVM?.getBookInfoString(), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
