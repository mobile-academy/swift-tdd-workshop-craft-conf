//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

class DataCache {

    let directoryName: String
    private(set) var cacheFileURL: URL

    var fileManager = FileManager.default

    init(directoryName: String) {
        self.directoryName = directoryName
        cacheFileURL = try! fileManager.url(for: .cachesDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: true).appendingPathComponent(directoryName)
        try? fileManager.createDirectory(at: cacheFileURL, withIntermediateDirectories: true)
    }

    func data(identifiedBy name: String) -> Data? {
        let fileURL = cacheFileURL(identifiedBy: name)
        return try? Data(contentsOf: fileURL)
    }

    func save(_ data: Data, identifiedBy name: String) {
        let fileURL = cacheFileURL(identifiedBy: name)
        if !fileManager.fileExists(atPath: fileURL.absoluteString) {
            try? data.write(to: fileURL)
        }
    }

    private func cacheFileURL(identifiedBy name: String) -> URL {
        return cacheFileURL.appendingPathComponent(name)
    }
}
