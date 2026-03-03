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
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = MyPageSectionType.allCases[section]
        
        switch sectionType {
        case .profile:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = MyPageSectionType.allCases[indexPath.section]
        
        switch sectionType {
        case .profile:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageProfileCell.id, for: indexPath) as? MyPageProfileCell else { return UICollectionViewCell() }
            cell.config(name: "SYB", email: "test@test.com")
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
}
