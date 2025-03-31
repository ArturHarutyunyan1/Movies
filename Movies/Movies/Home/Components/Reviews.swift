//
//  Reviews.swift
//  Movies
//
//  Created by Artur Harutyunyan on 31.03.25.
//

import SwiftUI

struct ReviewsView: View {
    var reviews: Reviews
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Reviews")
                .font(.custom("Poppins-Bold", size: 25))
                .foregroundColor(.white)
            
            if reviews.results.count > 0 {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(reviews.results, id: \.id) { review in
                            reviewItem(author: review.author, content: review.content)
                        }
                    }
                }
            } else {
                Text("Nothing found")
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func reviewItem(author: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(author)
                .font(.custom("Poppins-Bold", size: 20))
                .foregroundColor(.white)
            Text(content)
                .font(.custom("Poppins-Medium", size: 18))
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(8)
    }
}
