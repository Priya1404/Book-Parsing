//
//  LanguageDetector.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 25/09/23.
//

import Foundation
import NaturalLanguage

func detectedLanguage(for string: String) -> String? {
    let recognizer = NLLanguageRecognizer()
    recognizer.processString(string)
    guard let languageCode = recognizer.dominantLanguage?.rawValue else { return nil }
    let detectedLanguage = Locale.current.localizedString(forIdentifier: languageCode)
    return detectedLanguage
}
