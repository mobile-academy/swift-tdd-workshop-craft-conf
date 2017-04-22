//
//  PollManager.swift
//  TDDWorkshop
//
//  Created by Maciej Oczko on 11.11.2015.
//  Copyright © 2017 Mobile Academy. All rights reserved.
//

import Foundation

class PollManager {
    static let sharedInstance = PollManager()

    fileprivate(set) var pollAlreadySent: Bool = false

    func sendPoll(_ poll: Poll, completion: ((Bool) -> ())?) {
//TODO fix me using Firebase!
//        let pollObject = PFObject(className: "Poll", dictionary: poll.toJSON())
//        pollObject.saveInBackground {
//            [weak self] (success, error) in
//
//            self?.pollAlreadySent = success
//
//            if let error = error {
//                print("Error sending poll: \(error.description)")
//            }
//            if let completion = completion {
//                completion(success)
//            }
//        }
    }
}
