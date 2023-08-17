//
//  HomeHeader.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/17.
//

import UIKit

final class HomeHeader: UIView {
    
    // MARK: - Properties
    
    // enum으로 교체
    var configureView: String? {
        didSet {
            // backgroundImage 바꾸기
            
            // titleLabel 글자 색 바꾸기
            
            // leftButton / fotterButton tint 색 바꾸기
            
        }
    }
    
    
    
    // MARK: - Layout
    private lazy var homeCollection: UICollectionView = {
        let firstFrame = CGRect(x: 0,
                                y: 0,
                                width: self.frame.width,
                                height: self.frame.height)
        let Layout = UICollectionViewFlowLayout()
            Layout.scrollDirection = .horizontal
        
        let interval : CGFloat = 15
            Layout.sectionInset = UIEdgeInsets.init(top: 0,
                                                    left: interval,
                                                    bottom: 0,
                                                    right: interval)
        var view = UICollectionView(frame: firstFrame,
                                    collectionViewLayout: Layout)
        
            view.delegate = self
            view.dataSource = self
        
            view.register(HomeHeaderCollectionCell.self, forCellWithReuseIdentifier: ReuseIdentifier.homeCollectionCell)
        
//            view.alwaysBounceHorizontal = true
            view.backgroundColor = .clear
        
        return view
    }()
    
    
    
    
    
    
    
    

    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureHeader()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    // MARK: - Helper Functions
    private func configureHeader() {
        // 기본 backgroundColor
        self.backgroundColor = UIColor(white: 1, alpha: 0.3)
        
        self.addSubview(self.homeCollection)
    }
}



















// MARK: - CollectionView
extension HomeHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.homeCollectionCell, for: indexPath) as! HomeHeaderCollectionCell
        
        
        return cell
    }


    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("First")
    }
    
    
    // 아이템의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.frame.width - 8 - 10 - 1) / 3
        let height = width / 10 * 16
        return CGSize(width: width, height: height)
    }

    
    // 상하 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    // 좌우 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
