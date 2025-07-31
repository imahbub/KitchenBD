//
//  ContentView.swift
//  KitchenBD
//
//  Created by Md. Mahbub Hasan on 26/7/25.
//
import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @AppStorage("favoriteRecipes") private var favoriteRecipesData: Data = Data()
    @State private var favoriteRecipes: [CardData] = []
    
    // Filter states
    @State private var selectedOrigin: String = "All"
    @State private var selectedServingTime: ServingTime? = nil
    @State private var selectedMainIngredient: MainIngredient? = nil
    @State private var showingFilters = false
    
    // Get recipes from centralized repository
    let recipes = RecipeRepository.shared.allRecipes
    let uniqueOrigins = RecipeRepository.shared.uniqueOrigins
    
    var filteredRecipes: [Recipe] {
        var filtered = recipes
        
        // Filter by search text
        if !searchText.isEmpty {
            filtered = filtered.filter { recipe in
                recipe.title.localizedCaseInsensitiveContains(searchText) ||
                recipe.description.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Filter by origin
        if selectedOrigin != "All" {
            filtered = filtered.filter { $0.origin == selectedOrigin }
        }
        
        // Filter by serving time
        if let servingTime = selectedServingTime {
            filtered = filtered.filter { $0.servingTime == servingTime }
        }
        
        // Filter by main ingredient
        if let mainIngredient = selectedMainIngredient {
            filtered = filtered.filter { $0.mainIngredient == mainIngredient }
        }
        
        return filtered
    }
    
    // Check if any filters are active
    var hasActiveFilters: Bool {
        return selectedOrigin != "All" || selectedServingTime != nil || selectedMainIngredient != nil
    }
    
    // Get the count of active filters
    var activeFilterCount: Int {
        var count = 0
        if selectedOrigin != "All" { count += 1 }
        if selectedServingTime != nil { count += 1 }
        if selectedMainIngredient != nil { count += 1 }
        return count
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 0) {
                        // Filter controls
                        if showingFilters {
                            FilterView(
                                selectedOrigin: $selectedOrigin,
                                selectedServingTime: $selectedServingTime,
                                selectedMainIngredient: $selectedMainIngredient,
                                uniqueOrigins: uniqueOrigins
                            )
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                        }
                        
                        // Recipe list
                        LazyVStack(spacing: 16) {
                            ForEach(filteredRecipes, id: \.id) { recipe in
                                NavigationLink(destination: RecipeView(cardData: recipe.cardData)) {
                                    CardView(imageName: recipe.imageName,
                                            title: recipe.title,
                                            description: recipe.description)
                                        .overlay(
                                            Button(action: {
                                                toggleFavorite(recipe.cardData)
                                            }) {
                                                Image(systemName: isFavorite(recipe.cardData) ? "heart.fill" : "heart")
                                                    .foregroundColor(isFavorite(recipe.cardData) ? .red : .gray)
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
            .navigationTitle("Suras Recipes")
            .searchable(text: $searchText, prompt: "Search recipes...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 8) {
                        // Filter indicator
                        if hasActiveFilters {
                            Button(action: {
                                clearAllFilters()
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                        .foregroundColor(.blue)
                                        .font(.caption)
                                    
                                    Text("\(activeFilterCount)")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(width: 16, height: 16)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        // Filter toggle button
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showingFilters.toggle()
                            }
                        }) {
                            Image(systemName: showingFilters ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                                .foregroundColor(showingFilters ? .blue : .gray)
                        }
                    }
                }
            }
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
    
    private func isFavorite(_ recipe: CardData) -> Bool {
        return favoriteRecipes.contains { $0.title == recipe.title }
    }
    
    private func toggleFavorite(_ recipe: CardData) {
        if isFavorite(recipe) {
            favoriteRecipes.removeAll { $0.title == recipe.title }
        } else {
            favoriteRecipes.append(recipe)
        }
        
        if let encoded = try? JSONEncoder().encode(favoriteRecipes) {
            favoriteRecipesData = encoded
        }
    }
    
    private func clearAllFilters() {
        withAnimation(.easeInOut(duration: 0.3)) {
            selectedOrigin = "All"
            selectedServingTime = nil
            selectedMainIngredient = nil
        }
    }
}

// Filter view component
struct FilterView: View {
    @Binding var selectedOrigin: String
    @Binding var selectedServingTime: ServingTime?
    @Binding var selectedMainIngredient: MainIngredient?
    let uniqueOrigins: [String]
    
    var body: some View {
        VStack(spacing: 12) {
            // Origin filter
            VStack(alignment: .leading, spacing: 8) {
                Text("Origin")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(
                            title: "All",
                            isSelected: selectedOrigin == "All"
                        ) {
                            selectedOrigin = "All"
                        }
                        
                        ForEach(uniqueOrigins, id: \.self) { origin in
                            FilterChip(
                                title: origin,
                                isSelected: selectedOrigin == origin
                            ) {
                                selectedOrigin = origin
                            }
                        }
                    }
                    .padding(.horizontal, 4)
                }
            }
            
            // Serving time filter
            VStack(alignment: .leading, spacing: 8) {
                Text("Serving Time")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(
                            title: "All",
                            isSelected: selectedServingTime == nil
                        ) {
                            selectedServingTime = nil
                        }
                        
                        ForEach(ServingTime.allCases, id: \.self) { servingTime in
                            FilterChip(
                                title: servingTime.displayName,
                                isSelected: selectedServingTime == servingTime
                            ) {
                                selectedServingTime = selectedServingTime == servingTime ? nil : servingTime
                            }
                        }
                    }
                    .padding(.horizontal, 4)
                }
            }
            
            // Main ingredient filter
            VStack(alignment: .leading, spacing: 8) {
                Text("Main Ingredient")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(
                            title: "All",
                            isSelected: selectedMainIngredient == nil
                        ) {
                            selectedMainIngredient = nil
                        }
                        
                        ForEach(MainIngredient.allCases, id: \.self) { ingredient in
                            FilterChip(
                                title: ingredient.displayName,
                                isSelected: selectedMainIngredient == ingredient
                            ) {
                                selectedMainIngredient = selectedMainIngredient == ingredient ? nil : ingredient
                            }
                        }
                    }
                    .padding(.horizontal, 4)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// Filter chip component
struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.blue : Color(.systemGray5))
                .cornerRadius(16)
        }
    }
}

#Preview {
    ContentView()
}
