//
//  ReviewWriteViewModel.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import Foundation

class ReviewWriteViewModel {
    
    let reservation: Reservation
    
    var rating: Int = 0
    var content: String?
    
    var onSaveResult: ((Bool) -> Void)?
    var onValidError: ((String) -> Void)?
    
    init(reservation: Reservation) {
        self.reservation = reservation
    }
    
    var movieInfo: (title: String, date: String, posterPath: String) {
        return (reservation.safeTitle, reservation.safeWatchDate, reservation.safePosterPath)
    }
    
    func saveReview() {
        
        if rating < 1 {
            onValidError?("최소 1점 이상의 별점을 선택해 주세요.")
            return
        }
        
        let status = CoreDataManager.shared.saveReview(reservation: reservation, content: content, rating: rating)
        onSaveResult?(status)
    }
}
