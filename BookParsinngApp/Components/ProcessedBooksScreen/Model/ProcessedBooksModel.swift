//
//  ProcessedBooksModel.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 23/09/23.
//

import Foundation

class ProcessedBookModel {
    var title: NSAttributedString?
    var mostFrequent: NSAttributedString?
    var frequentSeven: NSAttributedString?
    var highestScoring: NSAttributedString?
    
    init(title: NSAttributedString, mostFrequent: NSAttributedString, frequentSeven: NSAttributedString, highestScoring: NSAttributedString) {
        self.title = title
        self.mostFrequent = mostFrequent
        self.frequentSeven = frequentSeven
        self.highestScoring = highestScoring
    }
}
