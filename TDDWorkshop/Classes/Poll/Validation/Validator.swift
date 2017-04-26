//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

protocol Validator {
	func validate(text: String?) -> Bool
	func validationFailMessage() -> String
}
