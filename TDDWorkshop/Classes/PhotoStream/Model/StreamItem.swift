//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class StreamItem: BackendObjectTransformable {

    var title: String
    var creationDate: Date
    var imageURL: URL?
    var imageData: Data?

    init(title: String, creationDate: Date) {
        self.title = title
        self.creationDate = creationDate
    }

    // MARK:  BackendObjectTransformable

    private struct Keys {
        static let title = "title"
        static let timestamp = "timestamp"
        static let imageURL = "imageURL"
    }

    private(set) static var name: String = "StreamItem"
    var identifier: String = ""

    convenience required init?(backendObject: BackendObject) {
        guard let title = backendObject[Keys.title] as? String,
              let timestamp = backendObject[Keys.timestamp] as? NSNumber else { return nil }
        let date = Date(timeIntervalSinceReferenceDate: timestamp.doubleValue)
        self.init(title: title, creationDate: date)
        if let stringURL = backendObject[Keys.imageURL] as? String, let url = URL(string: stringURL) {
            imageURL = url
        }
    }

    func transformToBackendObject() -> BackendObject {
        var backendObject: BackendObject = [:]
        backendObject[Keys.title] = title
        backendObject[Keys.timestamp] = NSNumber(floatLiteral: creationDate.timeIntervalSinceReferenceDate)
        if let url = imageURL {
            backendObject[Keys.imageURL] = url.absoluteString
        }
        return backendObject
    }
}