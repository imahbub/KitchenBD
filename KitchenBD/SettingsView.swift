//
//  SettingsView.swift
//  KitchenBD
//
//  Created by Md. Mahbub Hasan on 27/7/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("recipeFontSize") private var recipeFontSize: Double = 16.0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Display")) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Recipe Font Size")
                            Spacer()
                            Text("\(Int(recipeFontSize))pt")
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("Small")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Slider(value: $recipeFontSize, in: 12...24, step: 1)
                                .accentColor(.blue)
                            Text("Large")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        // Preview text
                        Text("Preview: This is how your recipe text will look")
                            .font(.system(size: recipeFontSize))
                            .padding(.top, 5)
                    }
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Developer")
                        Spacer()
                        Text("Mahbub Hasan")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Donate")
                        Spacer()
                        Button("OPEN") {
                            if let url = URL(string: "https://imahbub.com/donate") {
                                UIApplication.shared.open(url)
                            }
                        }
                        .foregroundColor(.blue)
                    }
                    
                }
                
                Section {
                    Text("Suras Recipe is a collection of easy to make recipe from around the country, and around the world ;)")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 8)
                }
            }
            .navigationTitle("Settings")
            
             
        }
    }
    
}

#Preview {
    SettingsView()
} 
