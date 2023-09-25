//
//  String+Extensions.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 25/09/23.
//

import Foundation

extension String {
    
    ///Helper to find the substring between a 'start' and 'end' string
    func customSlice(start: String, end: String) -> String? {
        guard let startIndex = self.lastIndexOf(substring: start) else {
            return nil
        }
        guard let endIndex = self.lastIndexOf(substring: end), endIndex > startIndex else {
            return nil
        }
        return String(self[startIndex..<endIndex])
    }

    /// Helper function to find the last index of a substring in a string
    func lastIndexOf(substring: String) -> String.Index? {
        var lastIndex: String.Index?
        var startIndex = self.startIndex

        while let range = self[startIndex...].range(of: substring, options: .backwards) {
            lastIndex = range.lowerBound
            startIndex = self.index(after: range.lowerBound)
        }
        return lastIndex
    }
}


