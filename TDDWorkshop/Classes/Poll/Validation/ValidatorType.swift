//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

enum ValidatorType {
    case text
    case comment
    case email

    static var allElements: [ValidatorType] = [.text, .comment, .email]
}
