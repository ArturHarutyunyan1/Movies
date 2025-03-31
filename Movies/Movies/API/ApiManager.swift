//
//  ApiManager.swift
//  Movies
//
//  Created by Artur Harutyunyan on 31.03.25.
//

import Foundation

enum ApiCallError: Error {
    case invalidResponse
    case statusCodeError(Int)
    case decodingError
    case invalidURL
}

@MainActor
class ApiManager: ObservableObject {
    @Published var popular: Popular?
    @Published var details: Details?
    @Published var errorMessage: String = ""
    @Published var posterPath: String
    private var apiKey: String
    
    init() {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API_KEY not found in Info.plist. Check your Secrets.xcconfig setup.")
        }
        guard let poster = Bundle.main.object(forInfoDictionaryKey: "POSTER_PATH") as? String else {
            fatalError("API_KEY not found in Info.plist. Check your Secrets.xcconfig setup.")
        }
        self.apiKey = key
        self.posterPath = poster
    }
    
    func makeRequest<T: Decodable>(endpoint: String, section: String, type: T.Type) async throws -> T {
        let urlString = "\(endpoint)\(section)?api_key=\(apiKey)&language=en-US&page=1"
        
        guard let url = URL(string: urlString) else {
            throw ApiCallError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiCallError.invalidResponse
        }
        guard httpResponse.statusCode == 200 else {
            throw ApiCallError.statusCodeError(httpResponse.statusCode)
        }
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
    
    func handleError(error: Error) {
        if let apiError = error as? ApiCallError {
            switch (apiError) {
            case .invalidResponse:
                self.errorMessage = "Invalid response"
            case .decodingError:
                self.errorMessage = "Error while decoding data"
            case .statusCodeError(let code):
                self.errorMessage = "Something went wrong - \(code)"
            case .invalidURL:
                self.errorMessage = "Invalid URL"
            }
        }
    }
    
    @MainActor
    func getPopularMovies() async {
        do {
            let decodedData: Popular = try await makeRequest(endpoint: "https://api.themoviedb.org/3/movie/", section: "popular", type: Popular.self)
            self.popular = decodedData
        } catch {
            handleError(error: error)
        }
    }
    
    @MainActor
    func getDetails(for id: Int) async {
        do {
            let decodedData: Details = try await makeRequest(endpoint: "https://api.themoviedb.org/3/movie/", section: "\(String(id))", type: Details.self)
            self.details = decodedData
        } catch {
            handleError(error: error)
        }
    }
}
