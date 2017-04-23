//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

@testable import TDDWorkshop

class ValidatorFake: Validator {
    private(set) var didCallValidateText: Bool = false
    private(set) var didCallFailMessage: Bool = false

    func validate(text: String?) -> Bool {
        self.didCallValidateText = true
        return false
    }

    func validationFailMessage() -> String {
        self.didCallFailMessage = true
        return ""
    }
}
