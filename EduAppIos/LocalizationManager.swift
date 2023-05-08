//
//  LocalizationManager.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/8/23.
//

import Foundation

class LocalizationManager {
    static let shared = LocalizationManager()

    private init() {}

    private let selectedLanguageKey = "selectedLanguage"

    func setSelectedLanguage(_ languageCode: String) {
        UserDefaults.standard.set(languageCode, forKey: selectedLanguageKey)
        UserDefaults.standard.synchronize()
    }

    func getSelectedLanguage() -> String? {
        return UserDefaults.standard.string(forKey: selectedLanguageKey)
    }
}

