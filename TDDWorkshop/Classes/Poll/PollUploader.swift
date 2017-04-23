//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

protocol PollUploader {
	var isPollAlreadySent: Bool { get }
	func sendPoll(_ poll: Poll, completion: ((Bool) -> ())?)
}
