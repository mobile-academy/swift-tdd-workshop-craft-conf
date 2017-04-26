//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

@testable import TDDWorkshop

class PollManagerFake: PollUploader {
	var completionFlag: Bool = true
	private(set) var didCallSendPoll: Bool = false
	private(set) var isPollAlreadySent: Bool = false

	func setPollAlreadySent(value: Bool) {
		isPollAlreadySent = value
	}

	func sendPoll(_ poll: Poll, completion: ((Bool) -> ())?) {
		self.didCallSendPoll = true
		if let completion = completion {
			completion(self.completionFlag)
		}
	}
}
