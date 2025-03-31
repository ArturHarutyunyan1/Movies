//
//  Overview.swift
//  Movies
//
//  Created by Artur Harutyunyan on 31.03.25.
//

import SwiftUI

struct Overview: View {
    var details: String
    var body: some View {
        VStack {
            HStack {
                Text("Overview")
                    .font(.custom("Poppins-Bold", size: 25))
                Spacer()
            }
            Text("\(details)")
        }
        .padding()
    }
}

