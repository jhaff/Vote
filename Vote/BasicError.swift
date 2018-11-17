//
//  BasicError.swift
//  Vote
//
//  Created by Jacob Haff on 11/17/18.
//  Copyright © 2018 Jacob Haff. All rights reserved.
//

import Foundation

class BasicError: Error {
    
    var localizedDescription: String {
        return message
    }
    private let message: String
    
    init(message: String) {
        self.message = message
    }
}
