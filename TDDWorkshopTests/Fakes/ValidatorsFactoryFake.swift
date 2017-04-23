//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
@testable import TDDWorkshop

class ValidatorsFactoryFake: ValidatorsFactory {
    let validator: Validator

    init(validator: Validator) {
        self.validator = validator
    }

    func validator(for type: ValidatorType) -> Validator {
        return validator
    }
}
