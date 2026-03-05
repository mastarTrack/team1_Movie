//
//  ReviewViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import UIKit

class ReviewViewController: UIViewController {
    
    private let reviewView = ReviewCollectionView()
    
    private var selectedIndex = 0
    
    private var availableData: [Reservation] = []
    private var writtenData: [Review] = []
    
    override func loadView() {
        self.view = reviewView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        loadAllData()
    }
}

extension ReviewViewController {
    private func setDelegate() {
        reviewView.delegate = self
        reviewView.collectionView.delegate = self
        reviewView.collectionView.dataSource = self
        
        reviewView.collectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: ReviewCollectionViewCell.id)
        reviewView.collectionView.register(AvailableReviewCollectionViewCell.self, forCellWithReuseIdentifier: AvailableReviewCollectionViewCell.id)
    }
}

extension ReviewViewController {
    
    private func loadAllData() {
        loadAvailableData()
        loadWrittenData()
        reviewView.collectionView.reloadData()
    }
    
    private func loadWrittenData() {
        self.writtenData = CoreDataManager.shared.fetchReview()
    }
    
    private func loadAvailableData() {
        guard let email = UserDefaults.standard.string(forKey: "userEmail") else { return }
        let allData = CoreDataManager.shared.fetchReservations(email: email)
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        self.availableData = allData.filter{ data in
            let dateData = "\(data.safeWatchDate) \(data.safeWatchTime)"
            guard let watchDate = formatter.date(from: dateData) else { return false }
            return watchDate < now && data.review == nil
        }.reversed()
        reviewView.collectionView.reloadData()
    }
}

extension ReviewViewController: ReviewCollectionViewDelegate {
    func didChangeSegment(index: Int) {
        self.selectedIndex = index
        reviewView.collectionView.reloadData()
    }
}


extension ReviewViewController: UICollectionViewDelegate {
    
}

extension ReviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedIndex == 0 {
            return writtenData.count
        } else {
            return availableData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if selectedIndex == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.id, for: indexPath) as? ReviewCollectionViewCell else { return UICollectionViewCell() }
            let item = writtenData[indexPath.item]
            cell.config(data: item)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvailableReviewCollectionViewCell.id, for: indexPath) as? AvailableReviewCollectionViewCell else { return UICollectionViewCell() }
            let item = availableData[indexPath.row]
            cell.delegate = self
            cell.config(data: item)
            return cell
        }
    }
}

extension ReviewViewController: AvailableReviewCollectionViewCellDelegate {
    func didTapWriteButton(cell: AvailableReviewCollectionViewCell) {
        guard let indexPath = reviewView.collectionView.indexPath(for: cell) else { return }
        
        let reservation = availableData[indexPath.item]
        showReviewModal(data: reservation)
    }
    
    private func showReviewModal(data: Reservation) {
        let reviewWriteVC = ReviewWriteViewController()
        reviewWriteVC.reservationData = data
        
        reviewWriteVC.modalPresentationStyle = .pageSheet
        self.present(reviewWriteVC, animated: true)
    }
}

