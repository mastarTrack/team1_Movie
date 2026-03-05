//
//  Reservation.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import Foundation

extension Reservation {
    var safeId: UUID {
        id ?? UUID()
    }
    var safeTitle: String {
        title ?? " 제목없음"
    }
    var safePosterPath: String {
        posterPath ?? ""
    }
    var safeTheaterName: String {
        theaterName ?? "극장 이름 없음"
    }
    var safeWatchDate: String {
        watchDate ?? ""
    }
    var safeWatchTime: String {
        watchTime ?? ""
    }
    var intAdult: Int {
        Int(adult)
    }
    var intChild: Int {
        Int(child)
    }
    var intPrice: Int {
        Int(totalPrice)
    }
}
