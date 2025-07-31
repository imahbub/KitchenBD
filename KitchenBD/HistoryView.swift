//
//  HistoryView.swift
//  KitchenBD
//
//  Created by Md. Mahbub Hasan on 27/7/25.
//

import SwiftUI

struct HistoryView: View {
    @AppStorage("recipeHistory") private var recipeHistoryData: Data = Data()
    @State private var recipeHistory: [CardData] = []
    
    var body: some View {
        NavigationView {
            Group {
                if recipeHistory.isEmpty {
                    // Empty state
                    VStack(spacing: 20) {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("No Reading History")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Text("Recipes you view will appear here")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemGroupedBackground))
                } else {
                    // History list
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(recipeHistory, id: \.title) { recipe in
                                NavigationLink(destination: RecipeView(cardData: recipe)) {
                                    HStack(spacing: 12) {
                                        // Recipe image
                                        Image(recipe.imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 60, height: 60)
                                            .clipped()
                                            .cornerRadius(8)
                                        
                                        // Recipe details
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(recipe.title)
                                                .font(.headline)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.primary)
                                                .lineLimit(2)
                                            
                                            Text(recipe.description)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                                .lineLimit(2)
                                        }
                                        
                                        Spacer()
                                        
                                        // View indicator
                                        Image(systemName: "chevron.right")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding()
                                    .background(Color(.systemBackground))
                                    .cornerRadius(12)
                                    .shadow(radius: 2)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Reading History")
            .toolbar {
                if !recipeHistory.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Clear All") {
                            clearHistory()
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .onAppear {
                loadHistory()
            }
        }
    }
    
    private func loadHistory() {
        if let decoded = try? JSONDecoder().decode([CardData].self, from: recipeHistoryData) {
            recipeHistory = decoded
        }
    }
    
    private func clearHistory() {
        recipeHistory.removeAll()
        if let encoded = try? JSONEncoder().encode(recipeHistory) {
            recipeHistoryData = encoded
        }
    }
}

#Preview {
    HistoryView()
} 