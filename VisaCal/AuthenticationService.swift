//
//  AuthenticationService.swift
//  VisaCal
//
//  Created by Shauli Algawi on 31/10/2024.
//

protocol AuthenticationProtocol {
    func authenticateFor(reason: String, completion: @escaping (_ success: Bool, _ error: NSError?) -> Void)
}

import Foundation
import LocalAuthentication
import SwiftUI

class AuthenticationService: AuthenticationProtocol {
    
    func authenticateFor(reason: String, completion: @escaping (_ success: Bool, _ error: NSError?) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
           
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                
                guard error == nil else {
                    completion(false, error as NSError?)
                    return
                }
                completion(success, nil)
            }
        } else {
            
        }
    }
}
