//
//  SingleBookDataVM.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 23/09/23.
//

import Foundation

class SingleBookDataVM {
    
    fileprivate struct PageConstants {
        static let buttonInfoTitle = "Book Info"
        static let descriptionText = "Read as follows:"
    }
    
    //MARK: Properties
    fileprivate var title: String
    fileprivate var content: String
    fileprivate var mostFrequent: (String, Int) = ("", 0)
    fileprivate var frequentSeven: (String, Int) = ("", 0)
    fileprivate var highestScoring: (String, Int) = ("", 0)
    
    //MARK: Scrabble Scoring Data
    
    // Define Scrabble letter values based on Scrabble letter distributions
    let letterValues: [Character: Int] = [
        "a": 1, "b": 3, "c": 3, "d": 2, "e": 1, "f": 4, "g": 2, "h": 4, "i": 1, "j": 8, "k": 5, "l": 1,
        "m": 3, "n": 1, "o": 1, "p": 3, "q": 10, "r": 1, "s": 1, "t": 1, "u": 1, "v": 4, "w": 4, "x": 8,
        "y": 4, "z": 10
    ]
    
    let frenchLetterValues: [Character: Int] = [
        "a": 1, "b": 3, "c": 3, "d": 2, "e": 1, "f": 4, "g": 2, "h": 4, "i": 1, "j": 8, "k": 5, "l": 1,
        "m": 2, "n": 1, "o": 1, "p": 3, "q": 8, "r": 1, "s": 1, "t": 1, "u": 1, "v": 4, "w": 10, "x": 10,
        "y": 10, "z": 10
    ]
    
    let germanLetterValues: [Character: Int] = [
        "a": 1, "b": 3, "c": 4, "d": 1, "e": 1, "f": 4, "g": 2, "h": 2, "i": 1, "j": 6, "k": 4, "l": 2,
        "m": 3, "n": 1, "o": 2, "p": 4, "q": 10, "r": 1, "s": 1, "t": 1, "u": 1, "v": 6, "w": 3, "x": 8,
        "y": 10, "z": 3, "ä": 6, "ü": 6, "ö": 8
    ]
    
    //MARK: Init
    init (bookObject: Book) {
        self.title = bookObject.title
        self.content = bookObject.content
        let processedText = processText()
        mostFrequent = (processedText[0].word, processedText[0].count)
        frequentSeven = (processedText[1].word, processedText[1].count)
        highestScoring = (processedText[2].word, processedText[2].count)
        saveBookInfoToUserDefaults()
    }
    
    //MARK: Fileprivate Methods
    fileprivate func processText() -> [WordFrequency] {
        //Process parsed text to count word frequencies
        let words = content.lowercased().components(separatedBy: CharacterSet.whitespacesAndNewlines)
        var wordCounts: [String: Int] = [:]
        
        for word in words {
            if word.isEmpty { continue }
            wordCounts[word, default: 0] += 1
        }
        
        //Calculate most frequent word
        let mostFrequentWord = wordCounts.max { $0.value < $1.value }
        
        //Calculate most frequent 7-character word
        let mostFrequent7CharWord = wordCounts.filter { $0.key.count == 7 }.max { $0.value < $1.value }
        
        //Calculate highest scoring words based on Scrabble scoring
        let (highestScoringWord, highestScore) = findHighestScoringWord(in: content)
        
        return [
            WordFrequency(word: mostFrequentWord?.key ?? "N/A", count: mostFrequentWord?.value ?? 0),
            WordFrequency(word: mostFrequent7CharWord?.key ?? "N/A", count: mostFrequent7CharWord?.value ?? 0),
            WordFrequency(word: highestScoringWord, count: highestScore)
        ]
    }
    
    ///Calculate word score based on language of the text, detected using Natural Language Processing
    fileprivate func calculateWordScore(_ word: String, lang: LanguagesSupported) -> Int {
        let lowercasedWord = word.lowercased()
        
        switch lang {
        case .French:
            return lowercasedWord.reduce(0) { $0 + (frenchLetterValues[$1] ?? 0) }
        case .German:
            return lowercasedWord.reduce(0) { $0 + (germanLetterValues[$1] ?? 0) }
        default:
            return lowercasedWord.reduce(0) { $0 + (letterValues[$1] ?? 0)}
        }
        
    }
    
    fileprivate func findHighestScoringWord(in text: String) -> (word: String, score: Int) {
        var highestScoringWord = ""
        var highestScore = 0
        
        let language = detectedLanguage(for: text) ?? "English"
        let lang = LanguagesSupported(rawValue: language) ?? .English
        
        let words = text.lowercased().components(separatedBy: CharacterSet.whitespacesAndNewlines)
        for word in words {
            let score = calculateWordScore(word, lang: lang)
            if score > highestScore {
                highestScore = score
                highestScoringWord = word
            }
        }
        
        return (highestScoringWord, highestScore)
    }
    
    fileprivate func saveBookInfoToUserDefaults() {
        var bookInfo: [String: [String]] = [:]
        bookInfo["title"] = [title]
        bookInfo["mostFrequent"] = [mostFrequent.0, String(mostFrequent.1)]
        bookInfo["frequentSeven"] = [frequentSeven.0, String(frequentSeven.1)]
        bookInfo["highestScoring"] = [highestScoring.0, String(highestScoring.1)]
        
        var booksArray = UserDefaultsManager.sharedInstance.getValue(forKeyString: BookParsingConstants.UserDefaultsKeys.bookInfoKey) as? [[String: [String]]] ?? []
        if !booksArray.contains(where: { dict in
            dict["title"] == bookInfo["title"]
        }) {
            booksArray.append(bookInfo)
            UserDefaultsManager.sharedInstance.setValue(value: booksArray, keyString: BookParsingConstants.UserDefaultsKeys.bookInfoKey)
        }
    }
    
    //MARK: Getters
    func getTitle() -> String {
        return title
    }
    
    func getDescriptionLabel() -> String {
        return PageConstants.descriptionText
    }
    
    func getButtonTitle() -> String {
        return PageConstants.buttonInfoTitle
    }
    
    func getBookContent() -> String{
        return content.replacingOccurrences(of: title, with: "")
    }
    
    func getMostFrequentWordDetails() -> String {
        return "Most frequent word is: \"\(mostFrequent.0)\" with count: \(mostFrequent.1)"
    }
    
    func getMostFrequentSevenLetteredWordDetails() -> String {
        return "Most frequent 7-character word is: \"\(frequentSeven.0)\" with count: \(frequentSeven.1)"
    }
    
    func getHighestScoringWordDetails() -> String {
        return "Highest scoring word is: \"\(highestScoring.0)\" with score: \(highestScoring.1)"
    }
    
    func getBookInfoString() -> String {
        let bookInfo = getMostFrequentWordDetails() + "\r\n" +
        getMostFrequentSevenLetteredWordDetails() + "\n" +
        getHighestScoringWordDetails() + "\n"
        return bookInfo
    }
}

