//
//  Encodable+Dictionary.swift
//  Vote
//
//  Created by Jacob Haff on 11/17/18.
//  Copyright © 2018 Jacob Haff. All rights reserved.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw BasicError(message: "Not a dictionary")
        }
        return dictionary
    }
}
