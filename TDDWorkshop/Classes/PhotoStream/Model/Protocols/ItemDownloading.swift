//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

protocol ItemDownloading {
    func downloadItems(_ completion: @escaping ([StreamItem]?, Error?) -> ())
}
