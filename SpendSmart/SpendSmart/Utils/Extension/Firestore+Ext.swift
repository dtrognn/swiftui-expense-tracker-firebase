//
//  Firestore+Ext.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import FirebaseFirestoreInternal
import Foundation

extension Firestore {
    func decode<T: Codable>(_ type: T.Type, from document: DocumentSnapshot) -> T? {
        guard let dictionary = document.data(),
              let data = try? JSONSerialization.data(withJSONObject: dictionary),
              let object = try? JSONDecoder().decode(type, from: data)
        else {
            return nil
        }
        return object
    }
}
