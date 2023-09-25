//
//  BookParsingWorkerTests.swift
//  BookParsinngAppTests
//
//  Created by Priya Srivastava on 25/09/23.
//

import XCTest
@testable import BookParsinngApp

final class BookParsingWorkerTests: XCTestCase {
    
    var fileParserWorker: TextFileParserWorker!
    var expec = XCTestExpectation(description: "FetchList")

    override func setUpWithError() throws {
        fileParserWorker = TextFileParserWorker()
    }

    override func tearDownWithError() throws {
        fileParserWorker = nil
    }

    func testListOfBooksFetch() throws {
        let url = "https://www.gutenberg.org/cache/epub/2600/pg2600.txt"
        let _ = fileParserWorker.getFileData(url: url) { [weak self] (successResponse, error) in
            if error == nil {
                if let bookItems = successResponse?.0, bookItems.count > 0 {
                    self?.expec.fulfill()
                    XCTAssert(true, "List of books generated")
                }
            } else {
                XCTFail(error?.localizedDescription ?? "Error")
            }
        }
    }

}
