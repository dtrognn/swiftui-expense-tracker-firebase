//
//  Firestore+Ext.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import FirebaseFirestore
import Foundation

extension Firestore {
    func decode<T: Codable>(_ type: T.Type, from document: DocumentSnapshot) -> T? {
        guard let dictionary = document.data() else { return nil }

        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            let object = try JSONDecoder().decode(type, from: data)
            return object
        } catch {
            return nil
        }
    }
}
