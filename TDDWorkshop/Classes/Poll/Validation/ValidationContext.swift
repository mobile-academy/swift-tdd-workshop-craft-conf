//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

struct ValidationContext {
    let validator: (String?) -> Bool
    let message: String
}
