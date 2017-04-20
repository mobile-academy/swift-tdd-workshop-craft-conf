//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

protocol ItemCreatingDelegate: class {
    func creator(_ creator: ItemCreating, didCreateItem item: StreamItem)
    func creator(_ creator: ItemCreating, failedWithError: Error)
}

protocol ItemCreating {

    weak var delegate: ItemCreatingDelegate? {get set}
    func createStreamItem()
}
