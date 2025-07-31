//
//  MainTabView.swift
//  KitchenBD
//
//  Created by Md. Mahbub Hasan on 27/7/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("Recipes")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart") 
                    Text("Favorites")
                }
            
            HistoryView()
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("History")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    MainTabView()
} 
