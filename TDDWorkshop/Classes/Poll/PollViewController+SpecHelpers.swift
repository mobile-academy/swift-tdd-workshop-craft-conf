//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import Eureka

@testable import TDDWorkshop

extension PollViewController {

	func simulateTextInput(forRowWithIdentifier identifier: String, text: String?) {
		guard let row = form.rowBy(tag: identifier) else {
			fatalError("Can't simulate text input for row '\(identifier)'")
		}
		beginEditing(of: row.baseCell as! Cell<String>)
		row.baseValue = text
		endEditing(of: row.baseCell as! Cell<String>)
	}

}
