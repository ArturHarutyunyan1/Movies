//
//  DatabaseManager.swift
//  Movies
//
//  Created by Artur Harutyunyan on 19.04.25.
//

import SwiftUI
import Firebase
import FirebaseCore

class DatabaseManager : ObservableObject {
    @Published var userBookmarks: [Bookmarks] = []
    
    func addToBookmarks(path: String, id: Int, title: String, email: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Bookmarks").document()
        
        let data: [String: Any] = [
            "path": path,
            "id": id,
            "title": title,
            "email": email
        ]
        
        ref.setData(data) {error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully!")
            }
        }
    }
}
