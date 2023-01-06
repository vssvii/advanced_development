//
//  Localization.swift
//  Navigation_2
//
//  Created by Developer on 13.12.2022.
//

import Foundation
import UIKit

private let appleLanguagesKey = "AppleLanguages"


struct Localized {
    static let language = "language".localized;
    
}

enum Language: String {
    case english = "en"
    case russian = "ru"
    case kazakh = "kk"
    
    static var language: Language {
        get {
            if let languageCode = UserDefaults.standard.string(forKey: appleLanguagesKey),
                let language = Language(rawValue: languageCode) {
                return language
            } else {
                let preferredLanguage = NSLocale.preferredLanguages[0] as String
                let index = preferredLanguage.index(preferredLanguage.startIndex, offsetBy: 2)
                guard let localization = Language(rawValue: String(preferredLanguage[..<index])) else {
                    return Language.russian
                }
                return localization
            }
        }
        set {
            UserDefaults.standard.set([newValue.rawValue], forKey: appleLanguagesKey)
            UserDefaults.standard.synchronize()
            
//            // restart app here
//            Apollo.shared.clearCache()
//            let appDelegate = AppDelegate.shared
//            appDelegate.setupUI()
            
        }
    }
    
    var title: String {
        switch self {
        case .russian:
            return "Русский"
        case .kazakh:
            return "Қазақша"
        case .english:
            return "English"
        }
    }
    
    var systemCode: String {
        switch self {
        case .russian:
            return "ru"
        case .kazakh:
            return "kk-KZ"
        case .english:
            return "en"
        }
    }
    
    var normalSystemCode: String {
        switch self {
        case .russian:
            return "ru-RU"
        case .kazakh:
            return "kk-KZ"
        case .english:
            return "en-US"
        }
    }
    
    var wcoSystemCode: String {
        switch self {
        case .russian:
            return "RU"
        case .kazakh:
            return "KZ"
        case .english:
            return "EN"
        }
    }
    
}


extension Bundle {
    static var localizedBundle: Bundle {
        let languageCode = Language.language.systemCode
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj") else {
            return Bundle.main
        }
        return Bundle(path: path)!
    }
}


extension String {
    var localized: String {
        return Bundle.localizedBundle.localizedString(forKey: self, value: nil, table: nil)
    }
    
    func localizedString(arg: String) -> String {
        let localizedString = NSLocalizedString(self, comment: "")
        let wantedString = String(format: localizedString, arg)
        return wantedString
    }
}

extension Language {
    static var withoutEnglishLocale: String {
        switch Language.language.rawValue {
        case "kk":
            return "kk"
        default:
            return "ru"
        }
    }
}


