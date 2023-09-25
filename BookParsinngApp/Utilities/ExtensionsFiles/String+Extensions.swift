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
    
    func sliceFirst(from startString: String, to endString: String) -> String? {
            // Find the range of the start string
            guard let startRange = self.range(of: startString) else {
                return nil
            }

            // Find the range of the end string
            guard let endRange = self.range(of: endString, range: startRange.upperBound..<self.endIndex) else {
                return nil
            }

            // Extract the substring between start and end
            let substringRange = startRange.upperBound..<endRange.lowerBound
            return String(self[substringRange])
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


