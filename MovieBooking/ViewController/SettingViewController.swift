//
//  SettingViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/4/26.
//

import UIKit

class SettingViewController: UIViewController {
    
    private let settingView = SettingCollectionView()
    private let viewModel = SettingViewModel()
    
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
        viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        return viewModel.getItem(sectionType: sectionType).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCollectionViewCell.id, for: indexPath) as? SettingCollectionViewCell else {
            return UICollectionViewCell() }
        let item = viewModel.getItem(sectionType: sectionType)[indexPath.item]
        let darkModeStatus = viewModel.isDarkMode
        cell.config(title: item.title, subTitle: item.subTitle, iconName: item.iconName, infoText: item.infoText, hasSwitch: item.hasSwitch, isDarkMode: darkModeStatus)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SettingHeader", for: indexPath) as! UICollectionViewListCell
        
        var content = header.defaultContentConfiguration()
        content.text = viewModel.sections[indexPath.section].headerTitle
        header.contentConfiguration = content
        return header
    }
}

extension SettingViewController: SettingCollectionViewCellDelegate {
    func didTapToggleSwitch(isDarkMode: Bool) {
        viewModel.toggleDarkMode(isDarkMode: isDarkMode)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
            }
        }
    }
}
