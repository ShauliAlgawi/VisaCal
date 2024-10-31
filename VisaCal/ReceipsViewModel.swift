//
//  ReceipsViewModel.swift
//  VisaCal
//
//  Created by Shauli Algawi on 31/10/2024.
//

import Foundation
import SwiftUI
import LocalAuthentication


class ReceipsViewModel: ObservableObject {
    @Published var receips: [Recipe] = []
    @Published var shouldDisplayAuthenticationError: Bool = false
    @Published var autheticationErrorText: String = ""
    
    let authenticationService: AuthenticationService
    
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
    }
    
    func onAppeare() {
        authenticationService.authenticateFor(reason: "In order to view the recipe detail", completion: {
            success, error in
            
            guard error == nil else {
                DispatchQueue.main.async { [weak self] in
                    self?.shouldDisplayAuthenticationError = true
                    self?.autheticationErrorText = error?.localizedDescription ?? "We were unable to authenticate you using FaceID"
                }
                return
            }
            if success {
                Task {
                    await self.loadFrom(url: "https://hf-android-app.s3-eu-west-1.amazonaws.com/android-test/recipes.json")
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.shouldDisplayAuthenticationError = true
                    self?.autheticationErrorText = "We were unable to authenticate you using FaceID"
                }
            }
        })
    }
    
    private func loadFrom(url: String) async {
        
        guard let url = URL(string: url) else {
            return
        }
        
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            DispatchQueue.main.async { [weak self] in
                do {
                    self?.receips = try JSONDecoder().decode([Recipe].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
