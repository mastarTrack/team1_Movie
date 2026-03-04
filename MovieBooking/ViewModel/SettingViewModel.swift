//
//  SettingViewModel.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/4/26.
//

import Foundation

class SettingViewModel {
    
    let sections = SettingSection.allCases
    
    func getItem(sectionType: SettingSection) -> [SettingMenu] {
        switch sectionType {
        case .passwordSection:
            return SettingData.passwordList
        case .darkModeSection:
            return SettingData.darkModeList
        case .infoSection:
            return SettingData.infoList
        }
    }
    
}
