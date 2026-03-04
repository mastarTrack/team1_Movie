//
//  MovieDetailViewModel.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/3/26.
//
import Foundation

class MovieDetailViewModel {
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
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    // 예매화면으로 넘길것
    var bookingMovie: Movie { movie }
    
    var title: String { movie.title }
    
    var overview: String {
        if movie.overview == "" {
            return "줄거리를 제공하지 않습니다."
        }
        return movie.overview
    }
    
    var genre: String {
        movie.genreIDs.compactMap {
            genreDictionary[$0]
        }.joined(separator: ", ")
    }
    
    var releaseDate: String {
        movie.releaseDate.replacingOccurrences(of: "-", with: ".")
    }
    
    var imageURL: String {
        guard let url = movie.backdropPath else { return "" }
        return "https://image.tmdb.org/t/p/w500\(url)"
    }
    
    var stars: String {
        let numOfStars = round(movie.voteAverage / 2)
        let votes = String(repeating: "⭐️", count: Int(numOfStars)) + "(\(movie.voteCount))"
        return votes
    }
}
