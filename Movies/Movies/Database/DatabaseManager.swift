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
    private var listener: ListenerRegistration?
    
    init () {
        getBookmarks()
    }
    
    func getBookmarks() {
        let db = Firestore.firestore()
        let ref = db.collection("Bookmarks")
        
        listener?.remove()
        
        listener = ref.addSnapshotListener {snapshot, error in
            if let error = error {
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                }
                return
            }
            if let documents = snapshot?.documents, !documents.isEmpty {
                DispatchQueue.main.async {
                    self.userBookmarks.removeAll()
                    for document in documents {
                        let data = document.data()
                        
                        let email = data["email"] as? String ?? ""
                        let path = data["path"] as? String ?? ""
                        let title = data["title"] as? String ?? ""
                        let id = data["id"] as? Int ?? 0
                        let mediaType = data["mediaType"] as? String ?? ""
                        
                        self.userBookmarks.append(Bookmarks(email: email, path: path, id: id, title: title, mediaType: mediaType))
                    }
                }
            }
        }
    }
    
    func addToBookmarks(path: String, id: Int, title: String, email: String, type: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Bookmarks").document()
        
        let data: [String: Any] = [
            "path": path,
            "id": id,
            "title": title,
            "email": email,
            "mediaType": type
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
