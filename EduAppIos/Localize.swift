//
//  Localize.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/8/23.
//

import Foundation


class Localize {
    class func getCurrentLanguage() -> String {
        let defaults = UserDefaults.standard
        let currentLanguage = defaults.string(forKey: "currentLanguage")
        if currentLanguage == nil {
            let systemLanguage = Locale.preferredLanguages.first
            return systemLanguage ?? "en"
        }
        return currentLanguage!
    }

    class func setCurrentLanguage(_ language: String) {
        let defaults = UserDefaults.standard
        defaults.set(language, forKey: "currentLanguage")
        defaults.synchronize()
    }

    class func getString(_ key: String) -> String {
        let bundle = Bundle.main
        let language = getCurrentLanguage()
        if let path = bundle.path(forResource: language, ofType: "lproj") {
            if let bundle = Bundle(path: path) {
                return bundle.localizedString(forKey: key, value: nil, table: nil)
            }
        }
        return ""
    }
}
