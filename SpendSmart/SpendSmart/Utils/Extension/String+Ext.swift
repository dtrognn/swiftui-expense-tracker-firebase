//
//  String+Ext.swift
//  SpendSmart
//
//  Created by dtrognn on 03/04/2024.
//

import SwiftUI

extension String {
    func toLocalizedStringKey() -> LocalizedStringKey {
        return LocalizedStringKey(self)
    }

    func trim(_ characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        return self.trimmingCharacters(in: characterSet)
    }
}
