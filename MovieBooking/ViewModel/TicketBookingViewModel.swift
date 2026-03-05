//
//  TicketBookingViewModel.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/3/26.
//
import Foundation
import UIKit

final class TicketBookingViewModel {
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    // 영상시간 장소는 서버에서 오는 값이 없기때문에 넣어줌
    let theaters = ["CGV 강남", "CGV 홍대", "메가박스 코엑스", "롯데시네마 월드타워"]
    let times = ["10:30", "13:20", "16:10", "19:00", "21:50"]
    let dates: [DateItem] = [
            .init(top: "오늘", date: "2/27", day: "금"),
            .init(top: "내일", date: "2/28", day: "토"),
            .init(top: "", date: "3/1", day: "일"),
            .init(top: "", date: "3/2", day: "월"),
            .init(top: "", date: "3/3", day: "화")
        ]
    
    let genreDictionary: [Int: String] = [
        28: "액션", 12: "모험", 16: "애니메이션", 35: "코미디",
        80: "범죄", 99: "다큐멘터리",18: "드라마", 10751: "가족",
        14: "판타지", 36: "역사", 27: "공포", 10402: "음악",
        9648: "미스터리", 10749: "로맨스", 878: "SF", 10770: "TV 영화",
        53: "스릴러", 10752: "전쟁",37: "서부"
    ]
    
    // 선택된 상태값 저장
    private(set) var selectedTheaterIndex: Int? = nil
    private(set) var selectedDateIndex: Int? = nil
    private(set) var selectedTimeIndex: Int? = nil
    
    private(set) var adultCount: Int = 0
    private(set) var childCount: Int = 0
    
    let adultPrice = 14000
    let childPrice = 11000
    
    // 값이 바뀌면 뷰컨에 전달함
    var onStateChange: (() -> Void)?
    
    // 총 가격
    var totalPrice: Int {
        adultCount * adultPrice + childCount * childPrice
    }
    
    // 구매하기 셀 표시용
    var totalPriceText: String {
        "\(totalPrice)원"
    }
    
    // 구매하기 버튼 로직
    // 다른 값들이 다 선택되있음, 인원이 한명이라도선택되어야함
    var isBookingEnabled: Bool {
        let selection = selectedTheaterIndex != nil && selectedDateIndex != nil && selectedTimeIndex != nil
        let people = (adultCount + childCount) > 0
        return selection && people
    }
    
    
    // MARK: 예매하기 저장 프로퍼티
    var moviePosterPath: String { movie.posterPath ?? "" }
    
    let email = UserDefaults.standard.string(forKey: "userEmail")
    
    var selectedTheaterName: String?
    var selectedWatchDate: String?
    var selectedWatchTime: String?
    
    var selectedPoster: String? {
        guard let path = movie.posterPath else { return nil }
        return "https://image.tmdb.org/t/p/w185" + path
    }
    
    // 예매완료 - 저장됨을 알림
    var onBooked: ((Bool) -> Void)?
    
    // coreData 저장
    func bookReservation() {
        let success = CoreDataManager.shared.saveReservation(
            title: title,
            posterPath: selectedPoster,
            theaterName: selectedTheaterName,
            watchDate: selectedWatchDate,
            watchTime: selectedWatchTime,
            adult: adultCount,
            child: childCount,
            totalPrice: totalPrice,
            seatNumber: nil,
            userEmail: email
        )
        onBooked?(success)
    }
    
    private func convertForSaveDate(_ date: String) -> String {
        let parts = date.split(separator: "/")
        guard parts.count == 2 else { return "" }
        
        let month = parts[0].count == 1 ? "0\(parts[0])" : String(parts[0])
        let day = parts[1].count == 1 ? "0\(parts[1])" : String(parts[1])
        
        return "2026-\(month)-\(day)"
    }
}


// MARK:  summaryView 표시용
extension TicketBookingViewModel {
    var title: String { movie.title }
    
    var genreText: String {
        movie.genreIDs.compactMap { genreDictionary[$0] }.joined(separator: ", ")
    }
    
    var releaseDateText: String {
        movie.releaseDate.replacingOccurrences(of: "-", with: ".")
    }
    
    var posterURL: URL? {
        guard let path = movie.posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w185\(path)")
    }
}

// date 구조체 선언
extension TicketBookingViewModel {
    struct DateItem {
        let top: String    // 오늘/내일
        let date: String   // 2/27
        let day: String    // 금
    }
}

// MARK: 콜렉션 뷰 관련
extension TicketBookingViewModel {
    enum Section: Int, CaseIterable {
        case theater
        case date
        case time
        case people
        case booking
        
        var headerTitle: String {
            switch self {
            case .theater: return "극장 선택"
            case .date:    return "날짜 선택"
            case .time:    return "시간 선택"
            case .people:  return "인원 선택"
            case .booking: return ""
            }
        }
    }
    
    // 섹션 개수
    func numberOfSections() -> Int { Section.allCases.count }
    
    // 섹션당 아이템 갯수
    func numberOfItems(section: Int) -> Int {
        guard let sec = Section(rawValue: section) else { return 0 }
        switch sec {
        case .theater: return theaters.count
        case .date:    return dates.count
        case .time:    return times.count
        case .people:  return 2
        case .booking: return 1
        }
    }
    
    // 컬렉션뷰 셀 선택 처리
    // 선택된 극장 날짜 시간 index를 저장
    func selectItem(at indexPath: IndexPath) {
        guard let sec = Section(rawValue: indexPath.section) else { return }

        switch sec {
        case .theater:
            selectedTheaterIndex = indexPath.item
            selectedTheaterName = theaters[indexPath.item]
            
        case .date:
            selectedDateIndex = indexPath.item
            let rawDate = dates[indexPath.item].date
            selectedWatchDate = convertForSaveDate(rawDate)
            
        case .time:
            selectedTimeIndex = indexPath.item
            selectedWatchTime = times[indexPath.item]
            
        default:
            return
        }

        onStateChange?()
    }
    
    // 인원선택 바꾸기
    func changeAdultCount(change: Int) {
        adultCount = max(0, adultCount + change)
        onStateChange?()
    }

    func changeTeenCount(change: Int) {
        childCount = max(0, childCount + change)
        onStateChange?()
    }
}
