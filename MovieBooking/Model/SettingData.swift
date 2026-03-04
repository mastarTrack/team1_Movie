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
    
    var headerTitle: String {
        switch self {
        case .passwordSection: return "보안"
        case .darkModeSection: return "다크 모드"
        case .infoSection: return "앱 정보"
        }
    }
}

struct SettingMenu {
    let title: String
    let subTitle: String?
    let iconName: String
    let infoText: String?
    let hasNav: Bool
    let hasSwitch: Bool
    
    init(title: String, subTitle: String? = nil, iconName: String, infoText: String? = nil, hasNav: Bool = false, hasSwitch: Bool = false) {
        self.title = title
        self.subTitle = subTitle
        self.iconName = iconName
        self.infoText = infoText
        self.hasNav = hasNav
        self.hasSwitch = hasSwitch
    }
}

struct SettingData {
    static let passwordList: [SettingMenu] = [
        SettingMenu(title: "비밀번호 변경", subTitle: "계정 보안을 위해 주기적으로 변경하세요", iconName: "lock", hasNav: true)
    ]
    
    static let darkModeList: [SettingMenu] = [
        SettingMenu(title: "다크 모드", subTitle: "라이트/다크 모드 전환하세요", iconName: "sun.max", hasSwitch: true)
    ] // 기능 연결 필요, 표시되는 subTitle 변경 필요
    
    static let infoList: [SettingMenu] = [
        SettingMenu(title: "버전", iconName: "info.circle", infoText: "1.0.0"),
        SettingMenu(title: "개발사", iconName: "figure.2.circle", infoText: "나머지공부 다 함께"),
        SettingMenu(title: "Github", iconName: "link.circle", infoText: "github.com")
    ]
}
