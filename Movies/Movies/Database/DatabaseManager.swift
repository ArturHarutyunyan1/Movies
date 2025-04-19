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
    
    func removeFromBookmarks(id: Int, email: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Bookmarks")
        
        ref.whereField("id", isEqualTo: id)
            .whereField("email", isEqualTo: email)
            .getDocuments {snapshot, error in
                if let error = error {
                    DispatchQueue.main.async {
                        print(error.localizedDescription)
                    }
                    return
                }
                if let documents = snapshot?.documents, !documents.isEmpty {
                    for document in documents {
                        let docID = document.documentID
                        
                        ref.document(docID).delete {error in
                            if let error = error {
                                DispatchQueue.main.async {
                                    print(error.localizedDescription)
                                }
                                return
                            }
                        }
                    }
                }
            }
    }
    
    func isMovieInBookmarks(id: Int, email: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let ref = db.collection("Bookmarks")
        
        ref.whereField("id", isEqualTo: id)
            .whereField("email", isEqualTo: email)
            .getDocuments {snapshot, error in
                if let error = error {
                    DispatchQueue.main.async {
                        print(error.localizedDescription)
                    }
                    completion(false)
                }
                if let document = snapshot?.documents, !document.isEmpty {
                    completion(true)
                } else {
                    completion(false)
                }
            }
    }
}
