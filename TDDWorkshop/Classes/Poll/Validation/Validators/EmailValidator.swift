//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

struct EmailValidator: Validator {

    func validate(text: String?) -> Bool {
        guard let text = text, !text.isEmpty else {
            return false
        }
        return validate(email: text)
    }

    func validationFailMessage() -> String {
        return "invalid email format"
    }

    private func validate(email: String) -> Bool {
        let pattern = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let regex = NSPredicate(format: "SELF MATCHES %@", pattern)
        return regex.evaluate(with: email)
    }
}
