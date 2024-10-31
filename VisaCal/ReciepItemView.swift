//
//  ReciepItem.swift
//  VisaCal
//
//  Created by Shauli Algawi on 31/10/2024.
//

import SwiftUI

struct ReciepItemView: View {
    @State var receip: Recipe
    @State var imageLoaded: Bool = false
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: receip.thumb)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .padding(.top)

            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
            .opacity(imageLoaded ? 1 : 0)
            .scaleEffect(imageLoaded ? 1 : 0.9)
            .onAppear {
                withAnimation(.easeIn(duration: 0.5)) {
                    imageLoaded = true
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            

            Spacer()
            HStack( spacing: 8) {
                VStack (alignment: .leading){
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(Font.system(size: 20).bold())
                            .foregroundColor(.primary)
                        Text(receip.name)
                            .font(Font.system(size: 20))
                            .foregroundColor(.primary)
                    }
                    VStack(alignment: .leading) {
                        Text("Fats")
                            .font(Font.system(size: 20).bold())
                            .foregroundColor(.primary)
                        Text(receip.fats)
                            .font(Font.system(size: 20))
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
                VStack (alignment: .trailing){
                    VStack {
                        Text("Calories")
                            .font(Font.system(size: 20).bold())
                            .foregroundColor(.primary)
                        Text(receip.calories)
                            .font(Font.system(size: 20))
                            .foregroundColor(.primary)
                    }
                    VStack {
                        Text("Carbos")
                            .font(Font.system(size: 20).bold())
                            .foregroundColor(.primary)
                        Text(receip.carbos)
                            .font(Font.system(size: 20))
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding(.leading)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ReciepItemView(receip: Recipe.mock)
}
