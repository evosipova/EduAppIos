//
//  LanguageManager.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/6/23.
//

import Foundation
import UIKit

class LanguageManager {
    static let shared = LanguageManager()
    private let selectedLanguageKey = "SelectedLanguage"

    private init() {}

    var selectedLanguage: String? {
        get {
            return UserDefaults.standard.string(forKey: selectedLanguageKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: selectedLanguageKey)
        }
    }
}
