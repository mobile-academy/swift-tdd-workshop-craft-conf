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

struct Poll {
    let name: String?
    let email: String?
    let comments: String?
    let items: [Item]?

    struct Item {
        var title: String?
        var rate: Int?
        var comment: String?
    }

    func isValid() -> Bool {
        return self.toJSON() != nil
    }

    func toJSON() -> [String:AnyObject]? {
        guard let name = self.name else {
            return nil
        }
        guard let email = self.email else {
            return nil
        }
        return [
                "name": name as AnyObject,
                "email": email as AnyObject,
                "comments": self.comments as AnyObject ?? "" as AnyObject,
                "items": self.items?.map {
                    [
                            "title": $0.title ?? "",
                            "rate": $0.rate ?? 0,
                            "comment": $0.comment ?? ""
                    ]
                } as AnyObject ?? [] as AnyObject
        ]
    }
}

class PollBuilder {
    fileprivate var name: String?
    fileprivate var email: String?
    fileprivate var comments: String?
    fileprivate var items: [String:Poll.Item] = [:]

    func isValid() -> Bool {
        return self.poll().isValid()
    }

    func poll() -> Poll {
        return Poll(name: name, email: email, comments: comments, items: items.values.flatMap({ $0 }))
    }

    // MARK: Poll building

    func setName(_ name: String?) -> PollBuilder {
        self.name = name
        return self
    }

    func setEmail(_ email: String?) -> PollBuilder {
        self.email = email
        return self
    }

    func setComments(_ comments: String?) -> PollBuilder {
        self.comments = comments
        return self
    }

    func setRate(_ rate: Int?, forTitle title: String) -> PollBuilder {
        if var item = items[title] {
            item.rate = rate
        } else {
            items[title] = Poll.Item(title: title, rate: rate, comment: nil)
        }
        return self
    }

    func setComment(_ comment: String?, forTitle title: String) -> PollBuilder {
        if var item = items[title] {
            item.comment = comment
        } else {
            items[title] = Poll.Item(title: title, rate: nil, comment: comment)
        }
        return self
    }


}
