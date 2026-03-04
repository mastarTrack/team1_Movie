//
//  TicketBookingViewModel.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/3/26.
//
import Foundation

final class TicketBookingViewModel {
    private let movie: Movie
    
    let genreDictionary: [Int: String] = [
        28: "액션",
        12: "모험",
        16: "애니메이션",
        35: "코미디",
        80: "범죄",
        99: "다큐멘터리",
        18: "드라마",
        10751: "가족",
        14: "판타지",
        36: "역사",
        27: "공포",
        10402: "음악",
        9648: "미스터리",
        10749: "로맨스",
        878: "SF",
        10770: "TV 영화",
        53: "스릴러",
        10752: "전쟁",
        37: "서부"
    ]
    
    var selectedTheaterName: String? = "스크림"
    var selectedWatchDate: String? = "2/27"
    var selectedWatchTime: String? = "10:30"
    var adultCount: Int = 2
    var childCount: Int = 1
    var totalPrice: Int = 39000
    var posterPath: String = "https://image.tmdb.org/t/p/w185/nTbO6UF944b0VZrgypMK5rFYRSW.jpg"
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    // 저장됨을 알림
    var onBooked: ((Bool) -> Void)?
    
    var title: String { movie.title }
    
    var genreText: String {
        movie.genreIDs.compactMap { genreDictionary[$0] }.joined(separator: ", ")
    }
    
    var releaseDateText: String {
        movie.releaseDate.replacingOccurrences(of: "-", with: ".")
    }
    
    var posterURL: URL? {
        guard let path = movie.backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w185\(path)")
    }
    
    func bookReservation() {
        let success = CoreDataManager.shared.saveReservation(
            title: title,
            posterPath: posterPath,
            theaterName: selectedTheaterName,
            watchDate: selectedWatchDate,
            watchTime: selectedWatchTime,
            adult: adultCount,
            child: childCount,
            totalPrice: totalPrice,
            seatNumber: nil,
            userEmail: nil
        )
        onBooked?(success)
    }
}
