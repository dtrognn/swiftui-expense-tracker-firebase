//
//  StoreLocal.swift
//  SpendSmart
//
//  Created by dtrognn on 04/04/2024.
//

import Foundation

struct StoreLocal {
    static let shared = StoreLocal()

    func setValue(key: String, value: Any) {
        UserDefaults.standard.set(value, forKey: key)
    }

    func getStringValue(_ key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }

    func getBoolValue(_ key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }

    func getObjectValue(_ key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }

    func getArrayStringValue(_ key: String) -> [String]? {
        return UserDefaults.standard.stringArray(forKey: key)
    }

    func getIntegerValue(_ key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }

    func getDoubleValue(_ key: String) -> Double {
        return UserDefaults.standard.double(forKey: key)
    }
}
