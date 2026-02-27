//
//  SearchViewModel.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/27/26.
//

/*                DispatchQueue.main.async {
 self.searchView.tableView.reloadData()
 }*/

import Foundation

class SearchViewModel {
    
    var updateUI: (() -> Void)?
    
    private let imageURL = "https://image.tmdb.org/t/p/w500"
    
    private let networkManager = NetworkManager()
    
    private(set) var allMovies: [Movie] = []
    private(set) var viewMovies: [Movie] = []
    
    var movieCount: Int {
        return viewMovies.count
    }
    
    var isMovieEmpty: Bool {
        return viewMovies.isEmpty
    }
    
    func getMovieData(index: Int) -> Movie {
        return viewMovies[index]
    }
    
    func fetchMovies() {
        Task {
            do {
                async let nowPlaying = networkManager.fetchMovies(type: .NowPlaying)
                async let upComing = networkManager.fetchMovies(type: .upcoming)
                
                let unfilteredMovies = try await (nowPlaying + upComing)
                allMovies = removeDuplicatedData(movies: unfilteredMovies)
                viewMovies = allMovies
                updateUI?()
            } catch {
                print("Fetch Data Failed")
            }
        }
    }
    
    private func removeDuplicatedData(movies: [Movie]) -> [Movie] {
        var uniqueMovies: [Movie] = []
        for movie in movies {
            if !uniqueMovies.contains(where: { $0.id == movie.id }) {
                uniqueMovies.append(movie)
            }
        }
        return uniqueMovies
    }
    
    func search(searchText: String) {
        if searchText.isEmpty {
            viewMovies = allMovies
        } else {
            viewMovies = allMovies.filter { movie in
                movie.title.uppercased().contains(searchText.uppercased())
            }
        }
        updateUI?()
    }
    
    func getPosterURL(index: Int) -> URL? {
        guard let path = viewMovies[index].posterPath else { return nil }
        return URL(string: imageURL + path)
    }
}
