//
//  Constants.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 25/09/23.
//

import Foundation

public struct BookParsingConstants {
    
    struct StoryBoardIDs {
        static let ProcessedBooks = "ProcessedBooks"
        static let SingleBookData = "SingleBookData"
    }
    
    struct ViewControllerIDs {
        static let ProcessedBooksVC = "ProcessedBooksVC"
        static let SingleBookDataVC = "SingleBookDataVC"
    }
    
    struct CellIdentifierIDs {
        static let BooksListingCell = "BooksListingCell"
        static let ProcessedBookCell = "ProcessedBookCell"
    }
    
    struct UserDefaultsKeys {
        static let bookInfoKey = "Books_Info"
    }
}
