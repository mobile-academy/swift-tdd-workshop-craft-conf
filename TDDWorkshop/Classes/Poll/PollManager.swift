//
//  PollManager.swift
//  TDDWorkshop
//
//  Created by Maciej Oczko on 11.11.2015.
//  Copyright © 2017 Mobile Academy. All rights reserved.
//

import Foundation

class PollManager {
    static let shared = PollManager()
    let backendAdapting: BackendAdapting
    private let userDefaults: UserDefaults

    var isPollAlreadySent: Bool {
        get {
            return userDefaults.bool(forKey: "isPollAlreadySent")
        }
        set(newValue) {
            userDefaults.set(newValue, forKey: "isPollAlreadySent")
        }
    }

    init(backendAdapting: BackendAdapting = FirebaseAdapter(), userDefaults: UserDefaults = UserDefaults.standard) {
        self.backendAdapting = backendAdapting
        self.userDefaults = userDefaults
    }

    func sendPoll(_ poll: Poll, completion: ((Bool) -> ())?) {
        backendAdapting.write(poll)
        isPollAlreadySent = true
        completion?(true)
    }
}
