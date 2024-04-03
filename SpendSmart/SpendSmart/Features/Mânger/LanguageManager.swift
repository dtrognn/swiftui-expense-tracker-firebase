//
//  LanguageManager.swift
//  SpendSmart
//
//  Created by dtrognn on 03/04/2024.
//

import SwiftUI
import Combine

public enum LanguageCode: String {
    case vi = "vi"
    case en = "en"
    case system = "system"

    public func getLanguageCode() -> String {
        switch self {
        case .vi, .en:
            return rawValue
        case .system:
            let systemLanguage = Locale.current.languageCode
            let newLanguageCode = LanguageCode(rawValue: systemLanguage ?? "") ?? .vi
            return newLanguageCode.rawValue
        }
    }
}

public extension String {
    static let KEY_DEFAULT_LANGUAGE = "KEY_DEFAULT_LANGUAGE"
    static let KEY_SYSTEM_LANGUAGE = "KEY_SYSTEM_LANGUAGE"
}

public class LanguageManager: ObservableObject {
    public static let shared = LanguageManager()
    @Published public var currentLanguage: LanguageCode = .vi
    public var onChangeLanguage = PassthroughSubject<LanguageCode, Never>()
    public var onChangeLanguageBundle = PassthroughSubject<LanguageCode, Never>()

    private init() {
        loadLanguage()
    }

    public func setLanguage(_ languageCode: LanguageCode) {
        if languageCode == .system {
            setDefaultSystemLanguage(true)
        } else {
            setDefaultSystemLanguage(false)
        }

        currentLanguage = languageCode
        UserDefaults.standard.set(languageCode.getLanguageCode(), forKey: .KEY_DEFAULT_LANGUAGE)
        changeLanguage()
    }

    private func loadLanguage () {
        if isDefaultLanguage() {
            setLanguage(.system)
            return
        }

        if let languageString = UserDefaults.standard.string(forKey: .KEY_DEFAULT_LANGUAGE), let languageCode = LanguageCode(rawValue: languageString) {
            setLanguage(languageCode)
        } else {
            let languageCode = LanguageCode(rawValue: Locale.current.languageCode ?? "vi") ?? .vi
            setLanguage(languageCode)
        }
        print("Language current: \(currentLanguage)")
    }

    private func changeLanguage () {
        onChangeLanguageBundle.send(currentLanguage)
        onChangeLanguage.send(currentLanguage)
    }

    private func isDefaultLanguage() -> Bool {
        UserDefaults.standard.bool(forKey: .KEY_SYSTEM_LANGUAGE)
    }

    private func setDefaultSystemLanguage (_ value: Bool) {
        UserDefaults.standard.setValue(value, forKey: .KEY_SYSTEM_LANGUAGE)
    }
}
