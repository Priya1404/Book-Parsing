//
//  TextFileParserWorker.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 25/09/23.
//

import Foundation

class TextFileParserWorker {
    func getFileData(url: String, completion: @escaping(_ success: ([Book], String)?,  _ error: NSError?)-> ()) -> String {
        if let url = URL(string: url) {
            NetworkManager.shared.fetchTextDataFromURL(url) { result in
                switch result {
                case .success(let text):
                    let (books, content) = self.separateBooks(from: text)
                    completion((books, content), nil)
                    
                case .failure(let error):
                    print("Error fetching or parsing data: \(error.localizedDescription)")
                    completion(nil, error as NSError)
                }
            }
        }
        return ""
    }
    
    func substringUpToSpecificString(_ text: String, _ specificString: String) -> String? {
        if let range = text.range(of: specificString) {
            let substring = text[..<range.lowerBound]
            return String(substring)
        }
        return nil
    }
    
    func substringFromLastSpecificStringToEnd(_ text: String, _ specificString: String) -> String? {
        if let lastIndex = text.lastIndexOf(substring: specificString) {
            let substring = text[lastIndex..<text.endIndex]
            return String(substring)
        }
        return nil
    }
    
    func separateBooks(from parsedText: String) -> ([Book], String) {
        let start = "*** "
        let bookSeparator = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n"
        
        let bookComponents = parsedText.sliceFirst(from: start, to: bookSeparator)?
            .replacingOccurrences(of: "\r\n", with: "")
            .components(separatedBy: "    ")
            .filter{$0.contains(":")}
        ?? []
        
        var books: [Book] = []
        
        for (index, component) in bookComponents.enumerated() {
            let startString = bookComponents[index]
            let endString = (index+1 >= bookComponents.count) ? "" : bookComponents[index+1]
            var content = ""
            if index+1 != bookComponents.count {
                content = parsedText.customSlice(start: startString, end: endString) ?? ""
            } else {
                content = substringFromLastSpecificStringToEnd(parsedText, startString) ?? ""
            }
            let book = Book(title: component, content: content)
            books.append(book)
        }
        
        //Will take substring upto first occurrence *** to show in description of book of any language
        let content = substringUpToSpecificString(parsedText, start) ?? ""
        
        return (books, content)
    }
}
