//
//  ReservationDetailViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import UIKit

class ReservationDetailViewController: UIViewController {
    
    private let reservationView = ReservationCollectionView()
    
    private var upcomingResrvation: [Reservation] = []
    private var pastReservation: [Reservation] = []
    
    override func loadView() {
        self.view = reservationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        loadData()
    }
}

extension ReservationDetailViewController {
    private func setDelegate() {
        reservationView.collectionView.delegate = self
        reservationView.collectionView.dataSource = self
    }
}

extension ReservationDetailViewController {
    func loadData() {
        guard let email = UserDefaults.standard.string(forKey: "userEmail") else { return }
        let allData = CoreDataManager.shared.fetchReservations(email: email)
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        for data in allData {
            let dateData = "\(data.safeWatchDate) \(data.safeWatchTime)"
            
            if let watchDate = formatter.date(from: dateData) {
                if watchDate >= now {
                    upcomingResrvation.append(data)
                } else {
                    pastReservation.append(data)
                }
            }
        }
        
        if upcomingResrvation.isEmpty && pastReservation.isEmpty {
            let emptyLabel = UILabel()
            emptyLabel.text = "예매 내역이 없습니다."
            emptyLabel.textColor = .systemGray
            emptyLabel.textAlignment = .center
            reservationView.collectionView.backgroundView = emptyLabel
        } else {
            reservationView.collectionView.backgroundView = nil
        }
        
        pastReservation = pastReservation.reversed()
        reservationView.collectionView.reloadData()
    }
}

extension ReservationDetailViewController: UICollectionViewDelegate{
    
}
extension ReservationDetailViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReservationHeaderView.id, for: indexPath) as? ReservationHeaderView else { return UICollectionReusableView() }
        let title: String
        if indexPath.section == 0 {
            title = !upcomingResrvation.isEmpty ? "관람 예정" : "지난 예매"
        } else {
            title = "지난 예매"
        }
        header.config(title: title)
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var count = 0
        if !upcomingResrvation.isEmpty { count += 1}
        if !pastReservation.isEmpty { count += 1}
        return count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return !upcomingResrvation.isEmpty ? upcomingResrvation.count : pastReservation.count
        }
        return pastReservation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReservationDetailCell.id, for: indexPath) as? ReservationDetailCell else { return UICollectionViewCell() }
        
        let data: Reservation
        if indexPath.section == 0 {
            data = !upcomingResrvation.isEmpty ? upcomingResrvation[indexPath.item] : pastReservation[indexPath.item]
        } else {
            data = pastReservation[indexPath.item]
        }
        cell.config(data: data)
        return cell
    }
}
