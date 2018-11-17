//
//  Collections.swift
//  Vote
//
//  Created by Jacob Haff on 11/17/18.
//  Copyright © 2018 Jacob Haff. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum Collection: String {
    case polls = "polls"
    case users = "users"
    
    var ref: CollectionReference {
        return Firestore.firestore().collection(self.rawValue)
    }
}
