//
// Created by Maciej Oczko on 22.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

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

    func toJSON() -> [String: Any]? {
        guard let name = self.name else { return nil }
        guard let email = self.email else { return nil }
        return [
                "name": name,
                "email": email,
                "comments": comments ?? "",
                "items": items?.map {
                    [
                            "title": $0.title ?? "",
                            "rate": $0.rate ?? 0,
                            "comment": $0.comment ?? ""
                    ]
                } ?? []
        ]
    }
}

extension Poll: BackendObjectTransformable {
    static var name: String = ""

    var identifier: String {
        get {
            return ""
        }
        set {
        }
    }

    // This type cannot be constructed from backend object.
    init?(backendObject: BackendObject) {
        return nil
    }

    func transformToBackendObject() -> BackendObject {
        guard let json = toJSON() else  { fatalError() }
        return json
    }
}
