//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

struct DefaultValidatorsFactory: ValidatorsFactory {
	func validator(for type: ValidatorType) -> Validator {
		switch type {
			case .text: return IllegalSymbolsValidator()
			case .email: return EmailValidator()
			case .comment: return CharactersMinimalCountValidator(minimalCharactersCount: 10)
		}
	}
}
