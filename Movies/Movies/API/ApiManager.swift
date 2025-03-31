//
//  ApiManager.swift
//  Movies
//
//  Created by Artur Harutyunyan on 31.03.25.
//

import Foundation

class ApiManager: ObservableObject {
    func a() {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? "qwequeoiqueio"
        print(apiKey)
    }
}
