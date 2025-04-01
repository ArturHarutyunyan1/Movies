//
//  Card.swift
//  Movies
//
//  Created by Artur Harutyunyan on 01.04.25.
//

import SwiftUI

struct Card<T: Identifiable, Content: View>: View {
    @EnvironmentObject private var apiManager: ApiManager
    @Namespace private var animation
    var items: [T]
    var content: (T) -> Content
    
    var body: some View {
        HStack {
            ForEach(items) {item in
                content(item)
            }
        }
    }
}
