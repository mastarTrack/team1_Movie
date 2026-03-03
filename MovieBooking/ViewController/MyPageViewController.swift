//
//  MyPageViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/3/26.
//

import UIKit

class MyPageViewController: UIViewController {
    
    let myPageCollectionView = MyPageCollectionView()
    
    override func loadView() {
        self.view = myPageCollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    // HomeView 접근 시 상단 네비게이션 제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    // 다른 페이지로 접근 시 상단 네비게이션 다시 생성
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension MyPageViewController {
    private func setDelegate() {
        myPageCollectionView.collectionView.delegate = self
        myPageCollectionView.collectionView.dataSource = self
    }
}

extension MyPageViewController: UICollectionViewDelegate {
    
}

extension MyPageViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        MyPageSectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = MyPageSectionType.allCases[section]
        
        switch sectionType {
        case .profile:
            return 1
        case .menu:
            return MyPageMenu.menuList.count
        case .info:
            return MyPageInfo.infoList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = MyPageSectionType.allCases[indexPath.section]
        
        switch sectionType {
        case .profile:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageProfileCell.id, for: indexPath) as? MyPageProfileCell else { return UICollectionViewCell() }
            cell.config(name: "SYB", email: "test@test.com")
            return cell
            
        case .menu:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageMenuCell.id, for: indexPath) as? MyPageMenuCell else { return UICollectionViewCell() }
            let item = MyPageMenu.menuList[indexPath.row]
            cell.config(title: item.title, subTitle: item.subTitle, iconName: item.iconName, isLogout: item.isLogout)
            return cell
            
        case .info:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageInfoCell.id, for: indexPath) as? MyPageInfoCell else { return UICollectionViewCell() }
            let item = MyPageInfo.infoList[indexPath.row]
            cell.config(count: item.count, title: item.title)
            return cell
        }
    }
}
