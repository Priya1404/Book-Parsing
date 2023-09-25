//
//  TextFileParser.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 22/09/23.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    ///the fetchTextDataFromURL function fetches the .txt file from the specified URL and parses it into a String. The completion handler provides the parsed text or an error if fetching or parsing fails
    func fetchTextDataFromURL(_ url: URL, completion: @escaping (Result<String, Error>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let text = String(data: data, encoding: .utf8) else {
                let parsingError = NSError(domain: "com.priya.bookparsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse data"])
                completion(.failure(parsingError))
                return
            }
            
            completion(.success(text))
        }
        task.resume()
    }
}
