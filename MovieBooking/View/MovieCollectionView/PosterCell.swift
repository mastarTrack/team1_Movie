//
//  PosterCell.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 2/27/26.
//
import UIKit
import SnapKit
import Kingfisher

final class PosterCell: UICollectionViewCell {
    static let identifier = "PosterCell"
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 스크롤 빠르게해도 재사용 안전하게
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
    
    func setPoster(url: URL?) {
        imageView.kf.setImage(with: url)
    }
}
