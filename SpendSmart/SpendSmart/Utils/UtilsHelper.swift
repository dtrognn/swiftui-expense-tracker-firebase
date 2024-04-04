//
//  UtilsHelper.swift
//  SpendSmart
//
//  Created by dtrognn on 04/04/2024.
//

import Foundation

enum ValidateType {
    case phoneNumber
    case email
    case password
    case maxLeght(Int)
    case equalLength(Int)
    case notEmpty
    case notCheck
}

enum UtilsHelper {
    private static func isValidEmail(_ emailStr: String) -> Bool {
        let emailTrim = emailStr.trim()
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailTrim)
    }

    private static func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneNumberTrim = phoneNumber.trim()
        let regEx = "(84|0)([0-9]{9,14})"
        let pred = NSPredicate(format: "SELF MATCHES %@", regEx)
        return pred.evaluate(with: phoneNumberTrim)
    }

    static func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }

    static func isValidRegexPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[^A-Za-z\\d]).{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
}

extension UtilsHelper {
    static func checkValidate(_ text: String?, validateType: ValidateType) -> Bool {
        guard let text = text else { return false }

        switch validateType {
        case .notEmpty:
            return !text.isEmpty
        case .phoneNumber:
            if text.isEmpty {
                return false
            }
            return isValidPhoneNumber(text)
        case .email:
            if text.isEmpty {
                return false
            }
            return isValidEmail(text)
        case .maxLeght(let max):
            return text.count < max
        case .equalLength(let length):
            return text.count == length
        case .password:
            return isValidPassword(text)
        default:
            return true
        }
    }
}
