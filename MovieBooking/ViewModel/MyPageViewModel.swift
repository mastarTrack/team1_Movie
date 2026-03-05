//
//  MyPageViewModel.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/3/26.
//

import Foundation

class MyPageViewModel {
    
    let sections = MyPageSectionType.allCases
    let menuItems = MyPageMenu.menuList
    var infoItems: [MyPageInfo] = []
    
    var onUpdated: (() -> Void)?
    
    var onLogout: (() -> Void)?
    var showLogoutAlert: (() -> Void)?
    var navigateTo: ((Int) -> Void)?
    
    var userName: String {
        UserDefaults.standard.string(forKey: "userName") ?? "이름 정보 없음"
    }
    
    var userEmail: String {
        UserDefaults.standard.string(forKey: "userEmail") ?? "이메일 정보 없음"
    }
    
    func didSelectMenuItem(index: Int) {
        let item = menuItems[index]
        if item.isLogout {
            showLogoutAlert?()
            return
        }
        navigateTo?(index)
    }
    
    func confirmLogout() {
        removeUserData()
        onLogout?()
    }
    
    func removeUserData() {
        UserDefaults.standard.set(false, forKey: "isLogin")
        UserDefaults.standard.set(false, forKey: "isDarkMode")
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "userEmail")
    }
    
    func loadInfoItems() {
        guard let email = UserDefaults.standard.string(forKey: "userEmail") else { return }
        
        let allReservation = CoreDataManager.shared.fetchReservations(email: email)
        let reservationCount = allReservation.count
        
        let allReviews = CoreDataManager.shared.fetchReview()
        
        let myReviews = allReviews.filter { $0.reservation?.userEmail == email }
        let reviewCount = myReviews.count
        
        let averageRating: Double
        if !myReviews.isEmpty {
            let totalRating = myReviews.reduce(0) { $0 + Int($1.rating) }
            
            averageRating = Double(totalRating) / Double(myReviews.count)
        } else {
            averageRating = 0.0
        }
        
        self.infoItems = [
            MyPageInfo(count: reservationCount, title: "총 예매"),
            MyPageInfo(count: reviewCount, title: "리뷰 작성"),
            MyPageInfo(rating: averageRating, title: "평균 별점")
        ]
        onUpdated?()
    }
}
