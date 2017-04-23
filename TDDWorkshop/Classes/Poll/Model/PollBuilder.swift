//
// Created by Maciej Oczko on 22.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

final class PollBuilder {
    private var name: String?
    private var email: String?
    private var comments: String?
    private var items: [String: Poll.Item] = [:]

    func isValid() -> Bool {
        return create().isValid()
    }

    func create() -> Poll {
        return Poll(name: name, email: email, comments: comments, items: items.values.flatMap({ $0 }))
    }

    // MARK: Poll building

    @discardableResult
    func with(name: String?) -> PollBuilder {
        self.name = name
        return self
    }

    @discardableResult
    func with(email: String?) -> PollBuilder {
        self.email = email
        return self
    }

    @discardableResult
    func with(comments: String?) -> PollBuilder {
        self.comments = comments
        return self
    }

    @discardableResult
    func with(rate: Int?, forTitle title: String) -> PollBuilder {
        if var item = items[title] {
            item.rate = rate
        } else {
            items[title] = Poll.Item(title: title, rate: rate, comment: nil)
        }
        return self
    }

    @discardableResult
    func with(comment: String?, forTitle title: String) -> PollBuilder {
        if var item = items[title] {
            item.comment = comment
        } else {
            items[title] = Poll.Item(title: title, rate: nil, comment: comment)
        }
        return self
    }
}
