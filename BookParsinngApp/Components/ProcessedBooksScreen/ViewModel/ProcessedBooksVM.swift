//
//  ProcessedBooksVM.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 23/09/23.
//

import Foundation

class ProcessedBooksVM {
    
    //MARK: Pageconstants
    private struct PageConstants {
        static let title = "Processed Books"
        static let descriptionText = "Previously explored books are as follows: "
    }
    
    var processedBooksList = UserDefaultsManager.sharedInstance.getValue(forKeyString: BookParsingConstants.UserDefaultsKeys.bookInfoKey) as? [[String: [String]]] ?? []
    
    //MARK: Getters
    func getTitle() -> String{
        return PageConstants.title
    }
    
    func getDescriptionText() -> String{
        return PageConstants.descriptionText
    }
    
    func getNumberOfProcessedBooks() -> Int {
        return processedBooksList.count
    }
    
    func getProcessedBookData(at atIndex: Int) -> (String, [String], [String], [String]) {
        let bookInfo = processedBooksList[atIndex]
        
        let title = bookInfo["title"]?[0] ?? ""
        let mostFrequent = bookInfo["mostFrequent"] ?? []
        let frequentSeven = bookInfo["frequentSeven"] ?? []
        let highestScoring = bookInfo["highestScoring"] ?? []
        
        return (title, mostFrequent, frequentSeven, highestScoring)
    }
    
    func getBookTitleText(title: String) -> String{
        return "Book Title: \(title)"
    }
    
    func getMostFrequentText(mostFrequent: [String]) -> String{
        return "Most frequent word is \"\(mostFrequent[0])\" with count \"\(mostFrequent[1])\""
    }
    
    func getFrequentSevenText(frequentSeven: [String]) -> String{
        return "Most Frequent 7-Character word is \"\(frequentSeven[0])\" with count \"\(frequentSeven[1])\""
    }
    
    func getHighestScoringText(highestScoring: [String]) -> String{
        return "Highest Scoring word in Scrabble: \"\(highestScoring[0])\" with count \"\(highestScoring[1])\""
    }
}
