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
        let title = (indexPath.section) == 0 ? "관람 예정" : "지난 예매"
        header.config(title: title)
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? upcomingResrvation.count : pastReservation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReservationDetailCell.id, for: indexPath) as? ReservationDetailCell else { return UICollectionViewCell() }
        
        let data = (indexPath.section == 0) ? upcomingResrvation[indexPath.item] : pastReservation[indexPath.item]
        cell.config(data: data)
        return cell
    }
}
