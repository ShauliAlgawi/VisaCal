//
//  ContentView.swift
//  VisaCal
//
//  Created by Shauli Algawi on 31/10/2024.
//

import SwiftUI

struct ReciepsList: View {
    @ObservedObject var viewModel: ReceipsViewModel = ReceipsViewModel(authenticationService: AuthenticationService())
    var body: some View {
        
        NavigationStack {
            ScrollView {
                ForEach(viewModel.receips) {
                    recipe in
                    NavigationLink(value: recipe) {
                        ReciepItemView(receip: recipe)
                            .padding(.bottom)
                    }
                }
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetails(recipe: recipe)
            }
            .navigationTitle("Recipes")
        }
        .onAppear {
            viewModel.onAppeare()
        }
        .background(Color.clear)
    }
}

#Preview {
    ReciepsList()
}
