//
//  BiometricIDAuth.swift
//  Navigation_2
//
//  Created by Developer on 05.01.2023.
//

import Foundation
import LocalAuthentication


class LocalAuthorizationService {
    enum BiometricType {
        case none
        case touchID
        case faceID
        case unknown
    }
    
    enum BiometricError: LocalizedError {
        case authenticationFailed
        case userCancel
        case userFallback
        case biometryNotAvailable
        case biometryNotEnrolled
        case biometryLockout
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .authenticationFailed:
                return "Не удалось подтвердить вашу личность."
            case .userCancel:
                return "Вы нажали отмену."
            case .userFallback:
                return "Вы нажали пароль."
            case .biometryNotAvailable:
                return "Face ID/Touch ID недоступен."
            case .biometryNotEnrolled:
                return "Face ID/Touch ID не настроен."
            case .biometryLockout:
                return "Face ID/Touch ID заблокирован."
            case .unknown:
                return "Face ID/Touch ID может быть не настроен"
            }
        }
    }
    
    private let context = LAContext()
    private let policy: LAPolicy
    private let localizedReason: String
    
    private var error: NSError?
    
    init(
        policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics,
        localizedReason: String = "Подтвердите свою личность",
        localizedFallbackTitle: String = "Введите пароль приложения"
    ) {
        self.policy = policy
        self.localizedReason = localizedReason
        
        context.localizedFallbackTitle = localizedFallbackTitle
        context.localizedCancelTitle = "Отмена"
    }
    
    func authorizeIfPossible(
        completion: (Bool, BiometricType, BiometricError?) -> Void
    ) {
        // Asks Context if it can evaluate a Policy
        // Passes an Error pointer to get error code in case of failure
        guard context.canEvaluatePolicy(policy, error: &error) else {
            // Extracts the LABiometryType from Context
            // Maps it to our BiometryType
            let type = biometricType(for: context.biometryType)
            
            // Unwraps Error
            // If not available, sends false for Success & nil in BiometricError
            guard let error = error else {
                return completion(false, type, nil)
            }
            
            // Maps error to our BiometricError
            return completion(false, type, biometricError(from: error))
        }
        
        // Context can evaluate the Policy
        completion(true, biometricType(for: context.biometryType), nil)
    }
    
    func authorizationFinished(
        completion: @escaping (Bool, BiometricError?) -> Void
    ) {
        // Asks Context to evaluate a Policy with a LocalizedReason
        context.evaluatePolicy(policy, localizedReason: localizedReason) { [weak self] success, error in
            // Moves to the main thread because completion triggers UI changes
            DispatchQueue.main.async {
                if success {
                    // Context successfully evaluated the Policy
                    completion(true, nil)
                } else {
                    // Unwraps Error
                    // If not available, sends false for Success & nil for BiometricError
                    guard let error = error else { return completion(false, nil) }
                    
                    // Maps error to our BiometricError
                    completion(false, self?.biometricError(from: error as NSError))
                }
            }
        }
    }
    
    private func biometricType(for type: LABiometryType) -> BiometricType {
        switch type {
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        @unknown default:
            return .unknown
        }
    }
    
    private func biometricError(from nsError: NSError) -> BiometricError {
        let error: BiometricError
        
        switch nsError {
        case LAError.authenticationFailed:
            error = .authenticationFailed
        case LAError.userCancel:
            error = .userCancel
        case LAError.userFallback:
            error = .userFallback
        case LAError.biometryNotAvailable:
            error = .biometryNotAvailable
        case LAError.biometryNotEnrolled:
            error = .biometryNotEnrolled
        case LAError.biometryLockout:
            error = .biometryLockout
        default:
            error = .unknown
        }
        
        return error
    }
}
