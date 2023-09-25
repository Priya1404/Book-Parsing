//
//  ProcessedBooksVM.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 23/09/23.
//

import Foundation
import UIKit

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
    
    func getBookTitleText(title: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string:"Book Title: ")
        let boldString = NSAttributedString(string: "\(title)", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
        attributedString.append(boldString)
        return attributedString
    }
    
    func getAttributedTextString(str1: String, str2: String, bold1: String, bold2: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: str1)
        let attributedString2 = NSMutableAttributedString(string: str2)
        let boldString1 = NSAttributedString(string: bold1, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
        let boldString2 = NSAttributedString(string: bold2, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
        attributedString.append(boldString1)
        attributedString.append(attributedString2)
        attributedString.append(boldString2)
        return attributedString
    }
    
    func getMostFrequentText(mostFrequent: [String]) -> NSAttributedString{
        return getAttributedTextString(str1: "Most frequent word is: ", str2: " with count: ", bold1: "\(mostFrequent[0])", bold2: "\(mostFrequent[1])")
    }
    
    func getFrequentSevenText(frequentSeven: [String]) -> NSAttributedString{
        return getAttributedTextString(str1: "Most Frequent 7-Character word is: ", str2: " with count: ", bold1: "\(frequentSeven[0])", bold2: "\(frequentSeven[1])")
    }
    
    func getHighestScoringText(highestScoring: [String]) -> NSAttributedString{
        return getAttributedTextString(str1: "Highest Scoring word in Scrabble: ", str2: " with count: ", bold1: "\(highestScoring[0])", bold2: "\(highestScoring[1])")
    }
}
