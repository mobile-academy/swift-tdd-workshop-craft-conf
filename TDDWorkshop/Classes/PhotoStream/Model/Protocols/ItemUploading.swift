//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

protocol ItemUploading {
    func uploadItem(_ streamItem: StreamItem, completion: @escaping (Bool, Error?) -> ())
}
