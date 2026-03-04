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
    let infoItems = MyPageInfo.infoList
    
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
}
