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
    let movieSummaryView = MovieSummaryView()
    let viewModel: TicketBookingViewModel
    
    init(viewModel: TicketBookingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "예매하기"
        
        ticketBookingView.collectionView.dataSource = self
        
        movieSummaryView.config(
            posterURL: viewModel.posterURL,
            genre: viewModel.genreText,
            title: viewModel.title,
            date: viewModel.releaseDateText
        )
        
        viewModel.onBooked = { [weak self] success in
            guard let self else { return }
            print(success)
        }
        
        configureLayout()
    }
    
    private func configureLayout() {
        view.addSubview(ticketBookingView)
        view.addSubview(movieSummaryView)
        
        movieSummaryView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(150)
        }

        ticketBookingView.snp.makeConstraints {
            $0.top.equalTo(movieSummaryView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
}

extension TicketBookingViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 4   // 극장선택 2*2
        } else if section == 1{
            return 7   // 가로
        } else if section == 2 {
            return 5 // 시간선택 3*2
        } else if section == 3{
            return 2 // 인원선택
        } else {
            return 1 // 에매하기
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {

        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CenterLabelCell.identifier,
                for: indexPath
            ) as! CenterLabelCell

            cell.configure(text: "섹션0")
            return cell


        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TripleLabelCell.identifier,
                for: indexPath
            ) as! TripleLabelCell

            cell.configure(first: "A", second: "B", third: "C")
            return cell


        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CenterLabelCell.identifier,
                for: indexPath
            ) as! CenterLabelCell

            cell.configure(text: "섹션2")
            return cell


        case 3:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TicketCountCell.identifier,
                for: indexPath
            ) as! TicketCountCell

            cell.configure(title: "성인", priceText: "₩12,000", count: 0)
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BookingCell.identifier,
                for: indexPath
            ) as! BookingCell

            cell.configure(
                guideText: "인원을 선택해주세요",
                priceText: "0원",
            )
            
            // 예매하기 버튼 예매내용 저장 연결
            cell.onTapBooking = { [weak self] in
                self?.viewModel.bookReservation()
            }
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
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
            
        case 1: header.configure(title: "날짜 선택")
            
        case 2: header.configure(title: "시간 선택")
        
        default: header.configure(title: "인원 선택")
        }
        
        return header
    }
}


