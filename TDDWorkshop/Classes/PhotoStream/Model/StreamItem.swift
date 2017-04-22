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
    }

    private(set) static var name: String = "StreamItem"
    var identifier: String = ""

    convenience required init?(backendObject: BackendObject) {
        guard let title = backendObject[Keys.title] as? String,
              let timestamp = backendObject[Keys.timestamp] as? NSNumber else { return nil }
        let date = Date(timeIntervalSinceReferenceDate: timestamp.doubleValue)
        self.init(title: title, creationDate: date)
    }

    func transformToBackendObject() -> BackendObject {
        return [Keys.title: title,
                Keys.timestamp: NSNumber(floatLiteral: creationDate.timeIntervalSinceReferenceDate)]
    }
}

extension StreamItem {
    func image() -> UIImage? {
        return nil
//        return UIImage(data: imageData) //TODO fix me
    }
}
