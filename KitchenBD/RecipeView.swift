//
//  Recipe1View.swift
//  KitchenBD
//
//  Created by Md. Mahbub Hasan on 27/7/25.
//


import SwiftUI

struct RecipeView: View {
    let cardData: CardData
    @AppStorage("recipeFontSize") private var recipeFontSize: Double = 16.0
    @AppStorage("favoriteRecipes") private var favoriteRecipesData: Data = Data()
    @AppStorage("recipeHistory") private var recipeHistoryData: Data = Data()
    @State private var favoriteRecipes: [CardData] = []
    @State private var recipeHistory: [CardData] = []
    
    // Get the full recipe data from the repository
    private var recipe: Recipe? {
        RecipeRepository.shared.getRecipe(by: cardData.title)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Recipe Image
                Image(cardData.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(15)
                
                // Text Content with 24px horizontal padding
                VStack(alignment: .leading, spacing: 20) {
                    // Recipe Title
                    Text(cardData.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                                    // Cooking Time and Servings
                HStack {
                    Label(recipe?.cookingTime ?? "30 mins", systemImage: "clock")
                    Spacer()
                    Label(recipe?.servingSize ?? "4 servings", systemImage: "person.2")
                }
                .foregroundColor(.secondary)
                
                // Recipe Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(cardData.description)
                        .font(.system(size: recipeFontSize))
                        .foregroundColor(.secondary)
                        .lineLimit(nil)
                }
                
                // Ingredients Section
                VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredients")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(recipe?.ingredients ?? ["Ingredients not available"], id: \.self) { ingredient in
                                if !ingredient.isEmpty {
                                    Text("• \(ingredient)")
                                        .font(.system(size: recipeFontSize))
                                }
                            }
                        }
                        .foregroundColor(.secondary)
                    }
                    
                    // Instructions Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Instructions")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(recipe?.instructions ?? ["Instructions not available"], id: \.self) { instruction in
                                HStack(alignment: .top, spacing: 8) {
                                    Text("•")
                                        .font(.system(size: recipeFontSize, weight: .bold))
                                        .foregroundColor(.primary)
                                        .frame(width: 15, alignment: .leading)
                                    
                                    Text(instruction)
                                        .font(.system(size: recipeFontSize))
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 8)
            }
            .padding()
        }
        .navigationTitle("Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: 
            Button(action: {
                toggleFavorite()
            }) {
                Image(systemName: isFavorite() ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite() ? .red : .gray)
                    .font(.title2)
            }
        )
        .onAppear {
            loadFavorites()
            loadHistory()
            addToHistory()
        }
    }
    
    private func loadFavorites() {
        if let decoded = try? JSONDecoder().decode([CardData].self, from: favoriteRecipesData) {
            favoriteRecipes = decoded
        }
    }
    
    private func isFavorite() -> Bool {
        return favoriteRecipes.contains { $0.title == cardData.title }
    }
    
    private func toggleFavorite() {
        if isFavorite() {
            favoriteRecipes.removeAll { $0.title == cardData.title }
        } else {
            favoriteRecipes.append(cardData)
        }
        
        if let encoded = try? JSONEncoder().encode(favoriteRecipes) {
            favoriteRecipesData = encoded
        }
    }
    
    private func loadHistory() {
        if let decoded = try? JSONDecoder().decode([CardData].self, from: recipeHistoryData) {
            recipeHistory = decoded
        }
    }
    
    private func addToHistory() {
        // Remove if already exists to avoid duplicates
        recipeHistory.removeAll { $0.title == cardData.title }
        
        // Add to the beginning of the history
        recipeHistory.insert(cardData, at: 0)
        
        // Keep only the last 50 items to prevent the history from growing too large
        if recipeHistory.count > 50 {
            recipeHistory = Array(recipeHistory.prefix(50))
        }
        
        if let encoded = try? JSONEncoder().encode(recipeHistory) {
            recipeHistoryData = encoded
        }
    }
    
    
}

#Preview {
    NavigationView {
        RecipeView(cardData: CardData(imageName: "recipe1", title: "Fried Chicken Recipe", description: "Delicious fried chicken"))
    }
}
