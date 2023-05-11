//
//  MemoryViewModel.swift
//  EduAppIos
//
//  Created by Elizaveta Osipova on 5/10/23.
//

import Foundation



class MemoryViewModel {
    func updateGame3Plays(completion: @escaping () -> Void) {
        let defaults = UserDefaults.standard
        let currentGame3Plays = defaults.integer(forKey: "game3Plays")
        defaults.set(currentGame3Plays + 1, forKey: "game3Plays")
        completion()
    }
}
