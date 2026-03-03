//
//  MyPageData.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/3/26.
//

import Foundation


struct MyPageMenu {
    let title: String
    let subTitle: String
    let iconName: String
    let isLogout: Bool
    
    init(title: String, subTitle: String, iconName: String, isLogout: Bool = false) {
        self.title = title
        self.subTitle = subTitle
        self.iconName = iconName
        self.isLogout = isLogout
    }
    
    static let menuList: [MyPageMenu] = [
        MyPageMenu(title: "예매 내역", subTitle: "지난 예매 내역을 확인하세요", iconName: "ticket"), // 아이콘 ..
        MyPageMenu(title: "찜한 영화", subTitle: "관심 있는 영화를 저장하세요", iconName: "heart"),
        MyPageMenu(title: "설정", subTitle: "앱 설정을 관리하세요", iconName: "gearshape"),
        MyPageMenu(title: "로그아웃", subTitle: "계정에서 로그아웃합니다", iconName: "iphone.and.arrow.right.outward", isLogout: true) // 못찾겠습니다 ..
    ]
}
