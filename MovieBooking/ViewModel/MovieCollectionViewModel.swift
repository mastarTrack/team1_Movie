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
    var onErrorMessage: ((String) -> Void)?
    
    init(networkingService: Networking = NetworkManager()) {
        self.networkingService = networkingService
    }
    
    @MainActor
    func fetchMovieData() async {
        do {
            // async let : 비동기 작업을 일단 시작해두고 필요할때 한번에 await해서 받아옴, 바로 다음 줄로 넘어가면서 작업은 백그라운드에서 계속 진행
            async let NowPlaying = networkingService.fetchMovies(type: .nowPlaying)
            async let upcoming = networkingService.fetchMovies(type: .upcoming)
            async let popular = networkingService.fetchMovies(type: .popular)
            
            let (now, up, pop) = try await (NowPlaying, upcoming, popular)
            
            self.nowPlaying = now
            self.upcoming = up
            self.popular = pop
            
            self.onUpdate?()
        } catch {
            self.onErrorMessage?(makeErrorMessage(error))
        }
    }
    
    private func makeErrorMessage(_ error: Error) -> String {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                return "인터넷에 연결 할 수 없습니다."
            case .timedOut:
                return "요청 시간이 초과됐어요. 잠시 후 다시 시도해주세요."
            default:
                return "다시 시도해주세요."
            }
        }
        
        return "잠시 후 다시 시도해주세요."
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

    // 인덱스패스 위치에 표시할 Movie 하나를 반환하는 함수
    func getMovieInfo(at indexPath: IndexPath) -> Movie? {
        // index.Section은 숫자니까 rawValue로 연결
        guard let section = Section(rawValue: indexPath.section) else { return nil }
        // 섹션을 받아 왔으니 섹션에 해당하는 case 찾아서 해당 그룹 item에 넣어줌
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
