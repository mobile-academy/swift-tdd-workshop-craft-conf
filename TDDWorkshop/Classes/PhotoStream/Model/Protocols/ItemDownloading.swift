//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

protocol ItemDownloading {
    func downloadItems(_ completion: @escaping ([StreamItem]?, Error?) -> ())
    func downloadImage(for item: StreamItem, completion: @escaping () -> ())
}
