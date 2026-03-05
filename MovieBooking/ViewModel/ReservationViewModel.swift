//
//  ReservationViewModel.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import Foundation

class ReservationViewModel {
    
    var onUpdated: (() -> Void)?
    
    var upcomingResrvation: [Reservation] = []
    var pastReservation: [Reservation] = []
    
    var numberOfSections: Int {
        var count = 0
        if !upcomingResrvation.isEmpty { count += 1}
        if !pastReservation.isEmpty { count += 1}
        return count
    }
    
    var isEmpty: Bool {
        return upcomingResrvation.isEmpty && pastReservation.isEmpty
    }
    
    
    func loadData() {
        guard let email = UserDefaults.standard.string(forKey: "userEmail") else { return }
        let allData = CoreDataManager.shared.fetchReservations(email: email)
        
        var upcoming: [Reservation] = []
        var past: [Reservation] = []
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        for data in allData {
            let dateData = "\(data.safeWatchDate) \(data.safeWatchTime)"
            
            if let watchDate = formatter.date(from: dateData) {
                if watchDate >= now {
                    upcoming.append(data)
                } else {
                    past.append(data)
                }
            }
        }
        self.upcomingResrvation = upcoming
        self.pastReservation = past.reversed()
        onUpdated?()
    }
    
    func setHeaderTitle(section: Int) -> String {
        if section == 0 {
            return !upcomingResrvation.isEmpty ? "관람 예정" : "지난 예매"
        } else {
            return "지난 예매"
        }
    }
    
    func numberOfItems(section: Int) -> Int {
        if section == 0 {
            return !upcomingResrvation.isEmpty ? upcomingResrvation.count : pastReservation.count
        }
        return pastReservation.count
    }
    
    func getData(section: Int, item: Int) -> Reservation {
        if section == 0 {
            return !upcomingResrvation.isEmpty ? upcomingResrvation[item] : pastReservation[item]
        } else {
            return pastReservation[item]
        }
    }
}
