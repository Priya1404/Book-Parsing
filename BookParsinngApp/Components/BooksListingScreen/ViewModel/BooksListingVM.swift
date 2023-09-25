//
//  BooksListingVM.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 22/09/23.
//

import Foundation

class BooksListingVM {
    
    //MARK: PageConstants
    /// Page Constants is used to get constantValue
    private struct PageConstants {
        static let appTitle = "Book Parser"
        static let headingText = "Following Books are available to read:"
        static let pastButtonTitle = "Past Books"
        static let bookURL = "https://www.gutenberg.org/cache/epub/2600/pg2600.txt"
    }
    
    //MARK: Properties
    fileprivate var booksDataSource: [Book] = []
    fileprivate var description: String = ""
    
    //MARK: Setters
    func setBooksDataSource(books: [Book]) {
        booksDataSource = books
    }
    
    func setDescription(contentDescription: String) {
        description = contentDescription
    }
    
    //MARK: Getters
    func getAppTitle() -> String{
        return PageConstants.appTitle
    }
    
    func getHeadingText() -> String{
        return PageConstants.headingText
    }
    
    func getPastButtonTitle() -> String{
        return PageConstants.pastButtonTitle
    }
    
    func getBookURL() -> String {
        return PageConstants.bookURL
    }
    
    func getDescription () -> String{
        return description
    }
    
    func getNumberOfBooks() -> Int {
        return booksDataSource.count
    }
    
    func getBookTitle(forIndex index: Int) -> String {
        return booksDataSource[index].title
    }
    
    func getBook(forIndex index: Int) -> Book {
        return Book(title: booksDataSource[index].title, content: booksDataSource[index].content)
    }
}
