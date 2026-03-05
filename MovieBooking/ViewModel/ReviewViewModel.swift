//
//  ReviewViewModel.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import Foundation


class ReviewViewModel{
    
    var onUpdated: (() -> Void)?
    
    var selectedIndex: Int = 0 {
        didSet { onUpdated?() }
    }
    
    private var availableData: [Reservation] = []
    private var writtenData: [Review] = []
    
    var numberOfItems: Int {
        return selectedIndex == 0 ? writtenData.count : availableData.count
    }
    
    func getWrittenData(index: Int) -> Review {
        writtenData[index]
    }
    
    func getAvailableData(index: Int) -> Reservation {
        availableData[index]
    }
    
    func updateSelectedIndex(index: Int) {
        self.selectedIndex = index
    }
    
    func loadData() {
        loadWrittenData()
        loadAvailableData()
        onUpdated?()
    }
    
    private func loadWrittenData() {
        self.writtenData = CoreDataManager.shared.fetchReview()
    }
    
    private func loadAvailableData() {
        guard let email = UserDefaults.standard.string(forKey: "userEmail") else { return }
        let allData = CoreDataManager.shared.fetchReservations(email: email)
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        self.availableData = allData.filter{ data in
            let dateData = "\(data.safeWatchDate) \(data.safeWatchTime)"
            guard let watchDate = formatter.date(from: dateData) else { return false }
            return watchDate < now && data.review == nil
        }.reversed()
    }
    
}
