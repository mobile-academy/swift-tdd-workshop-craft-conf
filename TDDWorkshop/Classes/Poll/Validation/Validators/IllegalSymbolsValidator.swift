//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

struct IllegalSymbolsValidator: Validator {

	func validate(text: String?) -> Bool {
		guard let text = text, !text.isEmpty else {
			return false
		}
		return [
				CharacterSet.illegalCharacters,
				CharacterSet.symbols,
				CharacterSet.punctuationCharacters,
				CharacterSet.nonBaseCharacters,
				CharacterSet.controlCharacters
		].reduce(true) {
			$0 && text.rangeOfCharacter(from: $1) == nil
		}
	}

	func validationFailMessage() -> String {
		return "invalid characters"
	}
}
