//
//  AuthViewController.swift
//  DairyApp
//
//  Created by sss on 04.05.2023.
//

import UIKit
import LocalAuthentication

final class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        authenticateUser()
    }

    private func authenticateUser() {
        let context = LAContext()
        var error: NSError?

        
        // Check if device is compatible with biometric authentication
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
               // Use biometric authentication
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Unlock your diary using Face ID / Touch ID") { success, error in
                if success {
                    
                    // Biometric authentication successful
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                } else {
                    // Biometric authentication failed
                    print(error?.localizedDescription ?? "Unknown error")
                }
            }
        } else {
            // Biometric authentication not available
            print(error?.localizedDescription ?? "Unknown error")
        }
    }
}
