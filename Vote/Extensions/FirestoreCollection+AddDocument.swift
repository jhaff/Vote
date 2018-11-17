//
//  FirestoreCollection+AddDocument.swift
//  Vote
//
//  Created by Jacob Haff on 11/17/18.
//  Copyright © 2018 Jacob Haff. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension CollectionReference {
    func addDocument(model: WritableFirestoreModel) -> DocumentReference {
        return self.addDocument(data: model.toDictionary())
    }
    
    func addDocument(model: WritableFirestoreModel, completion: @escaping (Error?) -> Void) -> DocumentReference {
        return self.addDocument(data: model.toDictionary(), completion: completion)
    }
}
