//
//  Extension.swift
//  Navigation_2
//
//  Created by Developer on 18.12.2022.
//

import Foundation
import UIKit

extension UIColor {
    static var whiteBlackColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traits) -> UIColor in
                // Return one of two colors depending on light or dark mode
                return traits.userInterfaceStyle == .dark ?
                    UIColor(red: 255, green: 255, blue: 255, alpha: 1) :
                    UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            }
        } else {
            // Same old color used for iOS 12 and earlier
            return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    static var blackWhiteColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traits) -> UIColor in
                // Return one of two colors depending on light or dark mode
                return traits.userInterfaceStyle == .dark ?
                    UIColor(red: 0, green: 0, blue: 0, alpha: 1) :
                UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            }
        } else {
            // Same old color used for iOS 12 and earlier
            return UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        }
    }
}
