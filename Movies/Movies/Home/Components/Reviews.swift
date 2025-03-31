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
        VStack {
            HStack {
                Text("Reviews")
                    .font(.custom("Poppins-Bold", size: 25))
                Spacer()
            }
            VStack {
                if reviews.results.count > 0 {
                    ForEach(reviews.results, id: \.id) {review in
                        reviewItem(author: review.author, content: review.content)
                    }
                } else {
                    Text("Nothing found")
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func reviewItem(author: String, content: String) -> some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text("\(author)")
                            .font(.custom("Poppins-Bold", size: 20))
                        Spacer()
                    }
                    Text("\(content)")
                        .font(.custom("Poppins-Medium", size: 18))
                }
            }
            Rectangle()
                .fill(.gray)
        }
    }
}
