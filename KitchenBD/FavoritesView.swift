//
//  FavoritesView.swift
//  KitchenBD
//
//  Created by Md. Mahbub Hasan on 27/7/25.
//

import SwiftUI

struct FavoritesView: View {
    @AppStorage("favoriteRecipes") private var favoriteRecipesData: Data = Data()
    @State private var favoriteRecipes: [CardData] = []
    
    var body: some View {
        NavigationView {
            Group {
                if favoriteRecipes.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "heart")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("No Favorites Yet")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Tap the heart icon on any recipe to add it to your favorites")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(favoriteRecipes, id: \.title) { recipe in
                                NavigationLink(destination: RecipeView(cardData: recipe)) {
                                    CardView(imageName: recipe.imageName,
                                            title: recipe.title,
                                            description: recipe.description)
                                        .overlay(
                                            Button(action: {
                                                removeFromFavorites(recipe)
                                            }) {
                                                Image(systemName: "heart.fill")
                                                    .foregroundColor(.red)
                                                    .font(.title2)
                                                    .padding(8)
                                                    .background(Color.white)
                                                    .clipShape(Circle())
                                                    .shadow(radius: 2)
                                            }
                                            .padding(8),
                                            alignment: .topTrailing
                                        )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Favorites")
            .onAppear {
                loadFavorites()
            }
        }
    }
    
    private func loadFavorites() {
        if let decoded = try? JSONDecoder().decode([CardData].self, from: favoriteRecipesData) {
            favoriteRecipes = decoded
        }
    }
    
    private func removeFromFavorites(_ recipe: CardData) {
        favoriteRecipes.removeAll { $0.title == recipe.title }
        if let encoded = try? JSONEncoder().encode(favoriteRecipes) {
            favoriteRecipesData = encoded
        }
    }
}

#Preview {
    FavoritesView()
} 