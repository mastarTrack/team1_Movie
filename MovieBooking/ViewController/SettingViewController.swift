//
//  SettingViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/4/26.
//

import UIKit

class SettingViewController: UIViewController {
    
    private let settingView = SettingCollectionView()
    
    override func loadView() {
        self.view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
}

extension SettingViewController {
    private func setDelegate() {
        settingView.collectionView.delegate = self
        settingView.collectionView.dataSource = self
    }
}

extension SettingViewController: UICollectionViewDelegate {
    
}

extension SettingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SettingSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = SettingSection.allCases[section]
        
        switch sectionType {
        case .passwordSection:
            return SettingData.passwordList.count
        case .darkModeSection:
            return SettingData.darkModeList.count
        case .infoSection:
            return SettingData.infoList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = SettingSection.allCases[indexPath.section]
        
        let item: SettingMenu
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCollectionViewCell.id, for: indexPath) as? SettingCollectionViewCell else {
            return UICollectionViewCell() }
        switch sectionType {
        case .passwordSection:
            item = SettingData.passwordList[indexPath.item]
        case .darkModeSection:
            item = SettingData.darkModeList[indexPath.item]
        case .infoSection:
            item = SettingData.infoList[indexPath.item]
        }
        cell.config(title: item.title, subTitle: item.subTitle, iconName: item.iconName, infoText: item.infoText, hasSwitch: item.hasSwitch)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SettingHeader", for: indexPath) as! UICollectionViewListCell
        
        var content = header.defaultContentConfiguration()
        content.text = SettingSection.allCases[indexPath.section].headerTitle
        header.contentConfiguration = content
        return header
    }
}
