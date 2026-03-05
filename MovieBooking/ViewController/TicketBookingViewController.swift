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
        navigationItem.largeTitleDisplayMode = .never
        
        ticketBookingView.collectionView.dataSource = self
        ticketBookingView.collectionView.delegate = self
        
        movieSummaryView.config(
            posterURL: viewModel.posterURL,
            genre: viewModel.genreText,
            title: viewModel.title,
            date: viewModel.releaseDateText
        )
        
        viewModel.onBooked = { [weak self] result in
            guard self != nil else { return }
            showBookingResult(result: result)
        }
        
        viewModel.onStateChange = { [weak self] in
            self?.ticketBookingView.collectionView.reloadData()
        }
        
        configureLayout()
        
        func showBookingResult(result: Bool) {
            let title = result ? "예매 완료" : "예매 실패"
            let message = result ? "예매가 완료되었습니다." : "예매 실패했습니다."
            
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            
            let action = UIAlertAction(title: "확인", style: .default)
            alert.addAction(action)
            
            self.present(alert, animated: true)
        }
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

extension TicketBookingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath)
    }
}

extension TicketBookingViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let section = TicketBookingViewModel.Section(rawValue: indexPath.section) else {
                    return UICollectionViewCell()
                }

        
        switch section {
        case .theater:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CenterLabelCell.identifier,
                for: indexPath
            ) as! CenterLabelCell
            
            let text = viewModel.theaters[indexPath.item]
            cell.configure(text: text)
            let isSelected = (viewModel.selectedTheaterIndex == indexPath.item)
            cell.applySelectedStyle(isSelected)
            return cell


        case .date:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TripleLabelCell.identifier,
                for: indexPath
            ) as! TripleLabelCell
            let item = viewModel.dates[indexPath.item]
            cell.configure(first: item.top, second: item.date, third: item.day)
            
            let isSelected = (viewModel.selectedDateIndex == indexPath.item)
            cell.applySelectedStyle(isSelected)
            return cell


        case .time:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CenterLabelCell.identifier,
                for: indexPath
            ) as! CenterLabelCell
            let text = viewModel.times[indexPath.item]
            cell.configure(text: text)
            
            let isSelected = (viewModel.selectedTimeIndex == indexPath.item)
            cell.applySelectedStyle(isSelected)
            return cell


        case .people:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TicketCountCell.identifier,
                for: indexPath
            ) as! TicketCountCell

            if indexPath.item == 0 {
                cell.configure(title: "성인", priceText: "\(viewModel.adultPrice)원", count: viewModel.adultCount)
                
                // 인원설정 버튼이 눌렸다는 신호 보내면 할 뷰모델 로직 연결
                cell.onTapMinus = { [weak self] in self?.viewModel.changeAdultCount(change: -1) }
                cell.onTapPlus  = { [weak self] in self?.viewModel.changeAdultCount(change: +1) }
            } else {
                cell.configure(title: "청소년", priceText: "\(viewModel.childPrice)원", count: viewModel.childCount)
                cell.onTapMinus = { [weak self] in self?.viewModel.changeTeenCount(change: -1) }
                cell.onTapPlus  = { [weak self] in self?.viewModel.changeTeenCount(change: +1) }
            }
            
            return cell
            
            
        case .booking:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BookingCell.identifier,
                for: indexPath
            ) as! BookingCell

            cell.configure(
                guideText: viewModel.isBookingEnabled ? "예매가 가능합니다." : "인원을 선택해주세요.",
                priceText: viewModel.totalPriceText,
                isBookingEnabled: viewModel.isBookingEnabled
            )
            
            // 예매하기 버튼 예매내용 저장 연결
            cell.onTapBooking = { [weak self] in
                self?.viewModel.bookReservation()
            }
            
            return cell
        }
    }
    
    // 헤더설정
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


