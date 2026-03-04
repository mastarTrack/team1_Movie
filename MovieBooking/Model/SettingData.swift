//
//  SettingData.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/4/26.
//

import Foundation

enum SettingSection: CaseIterable {
    case passwordSection
    case darkModeSection
    case infoSection
}

struct SettingMenu {
    let title: String
    let subTitle: String?
    let iconName: String?
    let infoText: String?
    let hasSwitch: Bool
    
    init(title: String, subTitle: String? = nil, iconName: String? = nil, infoText: String? = nil, hasSwitch: Bool = false) {
        self.title = title
        self.subTitle = subTitle
        self.iconName = iconName
        self.infoText = infoText
        self.hasSwitch = hasSwitch
    }
}

struct SettingData {
    static let passwordList: [SettingMenu] = [
        SettingMenu(title: "비밀번호 변경", subTitle: "계정 보안을 위해 주기적으로 변경하세요", iconName: "lock.fill")
    ]
    
    static let darkModeList: [SettingMenu] = [
        SettingMenu(title: "다크 모드", subTitle: "라이트 모드로 표시 중", iconName: "sun.max.fill", hasSwitch: true)
    ] // 기능 연결 필요, 표시되는 subTitle 변경 필요
    
    static let infoList: [SettingMenu] = [
        SettingMenu(title: "버전", infoText: "1.0.0"),
        SettingMenu(title: "개발사", infoText: "나머지공부 다 함께"),
        SettingMenu(title: "Github", infoText: "github.com")
    ]
}
