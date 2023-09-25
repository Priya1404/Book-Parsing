//
//  ProcessedBooksModel.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 23/09/23.
//

import Foundation

class ProcessedBookModel {
    var title: String?
    var mostFrequent: String?
    var frequentSeven: String?
    var highestScoring: String?
    
    init(title: String, mostFrequent: String, frequentSeven: String, highestScoring: String) {
        self.title = title
        self.mostFrequent = mostFrequent
        self.frequentSeven = frequentSeven
        self.highestScoring = highestScoring
    }
}
