//
//  CardView.swift
//  KitchenBD
//
//  Created by Md. Mahbub Hasan on 27/7/25.
//

import SwiftUI

struct CardView: View {
    var imageName: String
    var title: String
    var description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Card Image
            if UIImage(named: imageName) != nil {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(12)
            } else {
                // Placeholder image when the specified image is not found
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .overlay(
                        VStack {
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                            Text("Image not found")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    )
                    .cornerRadius(12)
            }

            // Text Content Container
            VStack(alignment: .leading, spacing: 8) {
                // Card Title
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(2)

                // Card Description
                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
    }
}

// MARK: - Preview Provider
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(
            imageName: "placeholderImage", // Make sure to add a placeholderImage to your Assets.xcassets
            title: "Beautiful Landscape",
            description: "This is a stunning landscape photo, perfect for inspiring your next adventure or simply enjoying the view."
        )
    }
}
