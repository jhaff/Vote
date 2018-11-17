//
//  FirestoreModel.swift
//  Vote
//
//  Created by Jacob Haff on 11/17/18.
//  Copyright © 2018 Jacob Haff. All rights reserved.
//

import Foundation

protocol WritableFirestoreModel {
    func toDictionary() -> [String: Any]
}
