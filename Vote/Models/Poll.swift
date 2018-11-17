//
//  Poll.swift
//  Vote
//
//  Created by Jacob Haff on 11/11/18.
//  Copyright © 2018 Jacob Haff. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Poll: Encodable, Decodable {
    let id: String
    let userId: String
    let createdDate: Date
    let displayInFeed: Bool
    var votesForTop: Int
    var votesForBottom: Int
    var usersVoted: [String: Bool]
    
    private init() {
        self.id = "0"
        self.userId = "0"
        self.createdDate = Date()
        self.displayInFeed = true
        self.votesForTop = 0
        self.votesForBottom = 0
        self.usersVoted = [:]
    }
}

struct CreatablePoll: WritableFirestoreModel {
    let userId: String
    var displayInFeed: Bool
    let createdDate = FieldValue.serverTimestamp()
    
    func toDictionary() -> [String : Any] {
        return ["userId": userId,
                "displayInFeed": displayInFeed,
                "createdDate": createdDate]
    }
}
