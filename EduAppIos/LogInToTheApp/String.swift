//
//  String.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/6/23.
//

import Foundation

extension String {
    func localized() -> String {
        let language = LanguageManager.shared.selectedLanguage ?? "Русский"
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)!

        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
