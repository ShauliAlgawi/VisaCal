//
//  RecipeDetails.swift
//  VisaCal
//
//  Created by Shauli Algawi on 31/10/2024.
//

import SwiftUI

struct RecipeDetails: View {
    let recipe: Recipe
    @ObservedObject var viewModel = RecipeDetailsViewModel(authenticationService: AuthenticationService())
    @State var imageLoaded: Bool = false
    var body: some View {
        GeometryReader { proxy in
            if viewModel.isAuthenticated {
                VStack (alignment: .leading) {
                    AsyncImage(url: URL(string: recipe.image)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: proxy.size.width, maxHeight: proxy.size.height)
                            .opacity(imageLoaded ? 1 : 0)
                            .scaleEffect(imageLoaded ? 1 : 0.9)
                            .onAppear {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    imageLoaded = true
                                }
                            }
                        
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: proxy.size.width, maxHeight: proxy.size.height)
                    }
                    .edgesIgnoringSafeArea(.all)
                    
                    ScrollView {
                        VStack (alignment: .leading){
                            ForEach(displayableFields, id: \.self) { field in
                                VStack(alignment: .leading) {
                                    Text(field.displayName)
                                        .font(Font.system(size: 20).bold())
                                        .foregroundColor(.primary)
                                    Text(recipe[keyPath: field.keyPath])
                                        .font(Font.system(size: 20))
                                        .foregroundColor(.primary)
                                }
                                
                                Spacer()
                            }
                        }
                    }
                    
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.onAppeare()
        }
        .alert(isPresented: $viewModel.shouldDisplayAuthenticationError, content: {
            Alert( title: Text("Authentication Failure"),
                   message: Text(viewModel.autheticationErrorText))
        })
    }
}

#Preview {
    RecipeDetails(recipe: .mock)
}
