//
//  MyPageViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/3/26.
//

//TODO: 로그아웃 기능 연결 - 완료 (수정필요: Alert, 애니메이션 추가?)
//TODO: MVVM 구조 변경

import UIKit

class MyPageViewController: UIViewController {
    
    private let viewModel = MyPageViewModel()
    
    let collectionView = MyPageCollectionView()
    
    override func loadView() {
        self.view = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        bind()
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
    private func bind() {
        viewModel.onLogout = { [weak self] in
            self?.changeNavigationToLogin()
        }
        
        viewModel.showLogoutAlert = { [weak self] in
            let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            alert.addAction(UIAlertAction(title: "확인", style: .destructive) { _ in
                self?.viewModel.confirmLogout()
            })
            self?.present(alert, animated: true)
        }
    }
}

extension MyPageViewController {
    private func setDelegate() {
        collectionView.collectionView.delegate = self
        collectionView.collectionView.dataSource = self
    }
}

extension MyPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .profile:
            break
        case .menu:
            viewModel.didSelectMenuItem(index: indexPath.item)
        case .info:
            break
        }
    }
}

extension MyPageViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        
        switch sectionType {
        case .profile:
            return 1
        case .menu:
            return viewModel.menuItems.count
        case .info:
            return viewModel.infoItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .profile:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageProfileCell.id, for: indexPath) as? MyPageProfileCell else { return UICollectionViewCell() }
            cell.config(name: viewModel.userName, email: viewModel.userEmail)
            return cell
            
        case .menu:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageMenuCell.id, for: indexPath) as? MyPageMenuCell else { return UICollectionViewCell() }
            let item = viewModel.menuItems[indexPath.item]
            cell.config(title: item.title, subTitle: item.subTitle, iconName: item.iconName, isLogout: item.isLogout)
            return cell
            
        case .info:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageInfoCell.id, for: indexPath) as? MyPageInfoCell else { return UICollectionViewCell() }
            let item = viewModel.infoItems[indexPath.item]
            cell.config(count: item.count, title: item.title)
            return cell
        }
    }
}

extension MyPageViewController {
    private func changeNavigationToLogin () {
        let loginVC = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginVC)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}
