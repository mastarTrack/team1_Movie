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
        bind()
    }
}

extension SettingViewController {
    private func bind() {
        viewModel.navigateTo = { [weak self] in
            let passwordChangeVC = PasswordChangeViewController()
            self?.navigationController?.pushViewController(passwordChangeVC, animated: true)
        }
    }
}

extension SettingViewController {
    private func setDelegate() {
        settingView.collectionView.delegate = self
        settingView.collectionView.dataSource = self
    }
}

extension SettingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let sectionType = viewModel.sections[indexPath.section]
        let item = viewModel.getItem(sectionType: sectionType)[indexPath.item]
        
        if item.hasNav {
            viewModel.didSelectPasswordSection()
        }
    }
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
        cell.config(item: item, isDarkMode: darkModeStatus)
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
