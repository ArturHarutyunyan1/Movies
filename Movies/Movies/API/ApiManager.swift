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
    @Published var nowPlaying: NowPlaying?
    @Published var upcoming: Upcoming?
    @Published var details: Details?
    @Published var topRated: TopRated?
    @Published var showDetails: ShowDetails?
    @Published var reviews: Reviews?
    @Published var cast: CastResults?
    @Published var actor: ActorDetails?
    @Published var search: SearchResults?
    @Published var media: Media?
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
    
    func makeRequest<T: Decodable>(endpoint: String, type: T.Type) async throws -> T {
        let urlString = "\(endpoint)"
        print(urlString)
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
                print(error.localizedDescription)
            case .decodingError:
                self.errorMessage = "Error while decoding data"
                print(error.localizedDescription)
            case .statusCodeError(let code):
                self.errorMessage = "Something went wrong - \(code)"
                print(error.localizedDescription)
            case .invalidURL:
                self.errorMessage = "Invalid URL"
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func getPopularMovies() async {
        do {
            let decodedData: Popular = try await makeRequest(endpoint: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)", type: Popular.self)
            self.popular = decodedData
        } catch {
            handleError(error: error)
        }
    }
    
    @MainActor
    func getDetails(for id: Int, with type: String) async {
        do {
            if type == "movie" {
                let decodedData: Details = try await makeRequest(endpoint: "https://api.themoviedb.org/3/\(type)/\(String(id))?api_key=\(apiKey)", type: Details.self)
                self.details = decodedData
            } else {
                let decodedData: ShowDetails = try await makeRequest(endpoint: "https://api.themoviedb.org/3/\(type)/\(String(id))?api_key=\(apiKey)", type: ShowDetails.self)
                self.showDetails = decodedData
            }
        } catch {
            handleError(error: error)
        }
    }
    
    @MainActor
    func getReviews(for id: Int) async {
        do {
            let decodedData: Reviews = try await makeRequest(endpoint: "https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=\(apiKey)", type: Reviews.self)
            self.reviews = decodedData
        } catch {
            handleError(error: error)
        }
    }
    
    @MainActor
    func getCast(for id: Int, with: String) async {
        do {
            let decodedData: CastResults = try await makeRequest(endpoint: "https://api.themoviedb.org/3/\(with)/\(id)/credits?api_key=\(apiKey)", type: CastResults.self)
            self.cast = decodedData
        } catch {
            handleError(error: error)
        }
    }
    
    @MainActor
    func getActor(for name: String) async {
        do {
            let formattedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name
            let decodedData: ActorDetails = try await makeRequest(endpoint: "https://api.themoviedb.org/3/search/person?query=\(formattedName)&api_key=\(apiKey)", type: ActorDetails.self)
            self.actor = decodedData
            print(self.actor ?? "NIGGER")
        } catch {
            handleError(error: error)
        }
    }
    
    @MainActor
    func getSearchResults(for query: String) async {
        do {
            self.search = nil
            let formattedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
            let decodedData: SearchResults = try await makeRequest(endpoint: "https://api.themoviedb.org/3/search/multi?query=\(formattedQuery)&api_key=\(apiKey)", type: SearchResults.self)
            self.search = decodedData
        } catch {
            handleError(error: error)
        }
    }
    
    @MainActor
    func getMedia(for id: Int, type: String) async {
        do {
            let decodedData: Media = try await makeRequest(endpoint: "https://api.themoviedb.org/3/\(type)/\(id)/images?api_key=\(apiKey)", type: Media.self)
            self.media = decodedData
        } catch {
            handleError(error: error)
        }
    }
    
    @MainActor
    func getNowPlaying() async {
        do {
            let decodedData: NowPlaying = try await makeRequest(endpoint: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)", type: NowPlaying.self)
            self.nowPlaying = decodedData
        } catch {
            handleError(error: error)
        }
    }
    
    @MainActor
    func getTopRatedMovies() async {
        do {
            let decodedData: TopRated = try await makeRequest(endpoint: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)", type: TopRated.self)
            self.topRated = decodedData
        } catch {
            handleError(error: error)
        }
    }
    
    @MainActor
    func getUpcomingMovies() async {
        do {
            let decodedData: Upcoming = try await makeRequest(endpoint: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)", type: Upcoming.self)
            self.upcoming = decodedData
        } catch {
            handleError(error: error)
        }
    }
}
