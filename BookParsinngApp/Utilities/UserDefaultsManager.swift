//
//  UserDefaultsManager.swift
//  BookParsinngApp
//
//  Created by Priya Srivastava on 24/09/23.
//

import Foundation

class UserDefaultsManager {
        
    static let sharedInstance = UserDefaultsManager()
    
    // MARK: Helpers
    func standard () -> UserDefaults {
        return UserDefaults.standard
    }
    
    func setValue(value: Any, keyString: String) {
        standard().set(value, forKey: keyString)
    }
    
    func getValue(forKeyString: String) -> Any {
        let object = standard().object(forKey: forKeyString)
        return object ?? [[String: Any]]()
    }
}
