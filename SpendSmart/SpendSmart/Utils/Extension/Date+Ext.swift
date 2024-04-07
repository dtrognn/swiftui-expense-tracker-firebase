//
//  Date+Ext.swift
//  SpendSmart
//
//  Created by dtrognn on 07/04/2024.
//

import Foundation

extension Date {
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }

    var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
}
