//
//  NetworkManager.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 2/26/26.
//
import UIKit

enum MovieListType: String {
    case upcoming = "upcoming"
    case topRated = "top_rated"
    case popular = "popular"
    case NowPlaying = "now_playing"
}

class NetworkManager: Networking {
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    
    func makeUpcomingURL(apiKey: String, _ type: MovieListType) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/\(type.rawValue)"

        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "ko-KR"),
            URLQueryItem(name: "page", value: "1")
        ]
        
        return components.url
    }
      
    
    func fetchData<T:Decodable>(url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let successRange = 200..<300
        
        guard let response = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard successRange ~= response.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func fetchMovies(type: MovieListType) async throws -> [Movie] {
        guard let checkedApiKey = apiKey else {
            throw URLError(.fileDoesNotExist)
        }
        
        guard let url = makeUpcomingURL(apiKey: checkedApiKey, type) else {
            throw URLError(.badURL)
        }
        
        let response: MovieResponse = try await fetchData(url: url)
        return response.results
    }
}

/*
 사용시
 func fetchMovieData() {
     Task {
         do {
             let movies1 = try await networkingService.fetchMovies(type: .NowPlaying)
             print(movies1)
         } catch {
             print("🔥 real error:", error)
         }
     }
 }
 */



protocol Networking {
    func makeUpcomingURL(apiKey: String, _ type: MovieListType) -> URL?
    
    func fetchData<T:Decodable>(url: URL) async throws -> T
    
    func fetchMovies(type: MovieListType) async throws -> [Movie]
}
