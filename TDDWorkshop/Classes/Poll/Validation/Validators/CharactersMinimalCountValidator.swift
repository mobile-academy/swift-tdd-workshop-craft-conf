//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

struct CharactersMinimalCountValidator: Validator {
    let minimalCharactersCount: Int

    func validate(text: String?) -> Bool {
        guard let text = text, !text.isEmpty else {
            return false
        }
        return text.characters.count >= minimalCharactersCount
    }

    func validationFailMessage() -> String {
        return "less than \(minimalCharactersCount) characters"
    }
}
