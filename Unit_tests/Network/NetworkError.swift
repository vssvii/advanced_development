//
//  NetworkError.swift
//  JSON_Decode_Serialization
//
//    Created by Ibragim Assaibuldayev on 13.12.2022.
//

import Foundation
import UIKit


enum NetworkError: Error {
    
    case `default`
    case serverError
    case parseError(reason: String)
    case unknownError
}
