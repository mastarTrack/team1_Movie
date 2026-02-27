//
//  MovieListViewModel.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 2/26/26.
//
import UIKit

class MovieCollectionViewModel {
    private let networkingService: Networking
    
    private(set) var nowPlaying: [Movie] = []
    private(set) var upcoming: [Movie] = []
    private(set) var popular: [Movie] = []
    
    var onUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(networkingService: Networking = NetworkManager()) {
        self.networkingService = networkingService
    }
    
    func fetchMovieData() {
        Task {
            do {
                // async let : 비동기 작업을 일단 시작해두고 필요할때 한번에 await해서 받아옴, 바로 다음 줄로 넘어가면서 작업은 백그라운드에서 계속 진행
                async let NowPlaying = networkingService.fetchMovies(type: .NowPlaying)
                async let upcoming = networkingService.fetchMovies(type: .upcoming)
                async let popular = networkingService.fetchMovies(type: .popular)
                
                let (now, up, pop) = try await (NowPlaying, upcoming, popular)
                
                self.nowPlaying = now
                self.upcoming = up
                self.popular = pop
                
                
                self.onUpdate?()
                
            } catch {
                print("error:", error)
            }
        }
    }
}
