//
//  TicketBookingViewController.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/3/26.
//
import UIKit
import SnapKit

final class TicketBookingViewController: UIViewController {
    let ticketBookingView = TicketBookingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        ticketBookingView.collectionView.dataSource = self
        
        configureLayout()
    }
    
    private func configureLayout() {
        view.addSubview(ticketBookingView)

        ticketBookingView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension TicketBookingViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 4   // 극장선택 2*2
        } else if section == 1{
            return 7   // 가로
        } else if section == 2 {
            return 5 // 시간선택 3*2
        } else {
            return 2 // 인원선택
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: checkCell.identifier, for: indexPath) as! checkCell
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: BookingSectionHeaderView.identifier,
            for: indexPath
        ) as! BookingSectionHeaderView
        
        switch indexPath.section {
        case 0: header.configure(title: "극장 선택")
            
        case 1: header.configure(title: "시간 선택")
            
        default: header.configure(title: "기타")
        }
        
        return header
    }
}


