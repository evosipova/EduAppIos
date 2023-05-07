//
//  String+extension.swift
//  EduAppIos
//
//  Created by Настя Лазарева on 07.05.2023.
//

import Foundation


extension String{
    var localized: String{
        NSLocalizedString(
            self,
            comment: "\(self) could not be found in Localizable.strings"
        )
    }
}
