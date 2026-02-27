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
    
    // 각 섹션에다가 줄 아이템 갯수 주는 함수
    func numberOfItems(in section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .nowPlaying: return nowPlaying.count
        case .upcoming:   return upcoming.count
        case .popular:    return popular.count
        }
    }

    // 인덱스패스에 영화포스터 매치
    func putMovieInfo(at indexPath: IndexPath) -> Movie? {
        guard let section = Section(rawValue: indexPath.section) else { return nil }
        switch section {
            // 배열 범위체크
        case .nowPlaying:
            return nowPlaying.indices.contains(indexPath.item) ? nowPlaying[indexPath.item] : nil
        case .upcoming:
            return upcoming.indices.contains(indexPath.item) ? upcoming[indexPath.item] : nil
        case .popular:
            return popular.indices.contains(indexPath.item) ? popular[indexPath.item] : nil
        }
    }

    func makeImageURL(path: String?) -> URL? {
        guard let path = path else { return nil }
        
        let baseURL = "https://image.tmdb.org/t/p/"
        let size = "w154"
        
        return URL(string: baseURL + size + path)
    }
}

extension MovieCollectionViewModel {
    enum Section: Int, CaseIterable {
        case nowPlaying
        case upcoming
        case popular
        
        var title: String {
            switch self {
            case .nowPlaying: return "Now Playing"
            case .upcoming:   return "Upcoming"
            case .popular:    return "Popular"
            }
        }
    }
}
