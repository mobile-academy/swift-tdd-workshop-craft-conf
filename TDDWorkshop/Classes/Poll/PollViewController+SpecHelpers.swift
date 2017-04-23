//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

@testable import TDDWorkshop

extension PollViewController {

	func simulateTextInput(forRowWithIdentifier identifier: String, text: String?) {
		guard let row = form.rowBy(tag: identifier) else {
			fatalError("Can't simulate text input for row '\(identifier)'")
		}
		row.isHighlighted = true
		row.baseValue = text
		row.isHighlighted = false
	}

}
