//
//  SeatSelectionViewModel.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/5/26.
//

final class SeatSelectionViewModel {
    enum SeatState {
        case available
        case selected
        case Unavailable
    }
    
    // 바뀐 정보 보내는 콜백
    var onSeatStateChanged: ((Int) -> Void)? // 바뀐 좌석 index 전달
    var onSelectionChanged: (([String]) -> Void)? // 바뀐 좌석들 title(A01 같은거)
    
    // 선택가능 좌석 수
    var onLimitReached: ((Int) -> Void)?
    
    // 좌석 상태 저장
    private(set) var seatStates: [SeatState] = []
    private(set) var selectedSeatTitles: [String] = []
    
    // 선택 가능 인원
    private var maxSelectableCount: Int = 0
    
    
    // 시트의 초기 설정
    func setup(totalSeatsCount: Int, unavailableIndexes: [Int]) {
        seatStates = Array(repeating: .available, count: totalSeatsCount)
        
        for index in unavailableIndexes {
            seatStates[index] = .Unavailable
        }
        
        selectedSeatTitles.removeAll()
        // 좌석 번호 전달
        onSelectionChanged?(selectedSeatTitles)
    }
    
    // 선택가능 좌석 바꾸기
    func setMaxSelectableCount(_ count: Int) {
        maxSelectableCount = count
    }
    
    // 좌석 상태를 바꿔줌
    func updateSeatState(index: Int, title: String) {
        
        // 아예 선택 안되는 경우 제외
        guard seatStates[index] != .Unavailable else { return }
        
        // 선택 된게 또 눌렸을 때
        if seatStates[index] == .selected {
            seatStates[index] = .available
            selectedSeatTitles.removeAll { $0 == title }
            onSeatStateChanged?(index)
            onSelectionChanged?(selectedSeatTitles)
            return
        }
        
        // 선택 가능에서 골랐음으로 바꾼거 확인 (인원 제한)
        if selectedSeatTitles.count >= maxSelectableCount {
            onLimitReached?(maxSelectableCount)
            return
        }
        
        seatStates[index] = .selected
        selectedSeatTitles.append(title)
        onSeatStateChanged?(index)
        onSelectionChanged?(selectedSeatTitles)
    }
    
    var selectedSeatsForSave: String {
        selectedSeatTitles.joined(separator: ",")
    }
}
