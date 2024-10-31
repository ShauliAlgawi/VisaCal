//
//  RecipeDetailsViewModel.swift
//  VisaCal
//
//  Created by Shauli Algawi on 01/11/2024.
//

import Foundation

class RecipeDetailsViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var shouldDisplayAuthenticationError: Bool = false
    @Published var autheticationErrorText: String = ""
    let authenticationService: AuthenticationService
    
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
    }
    func onAppeare() {
        authenticationService.authenticateFor(reason: "This is private info") { [weak self] success, error in
            guard error == nil else {
                DispatchQueue.main.async { [weak self] in
                    self?.shouldDisplayAuthenticationError = true
                    self?.autheticationErrorText = error?.localizedDescription ?? "We were unable to authenticate you using FaceID"
                }
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.isAuthenticated = success
            }
        }
    }
}
