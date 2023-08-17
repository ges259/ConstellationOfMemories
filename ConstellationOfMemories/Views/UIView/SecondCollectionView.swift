//
//  SecondCollectionView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/17.
//

import UIKit

final class SecondCollectionView: UIView {
    
    // MARK: - Properties
    
    
    
    var secondMainDelegate: SecondMainDelegate?

    
    // MARK: - Layout
    private lazy var secondCollection: UICollectionView = {
        let secondFrame = CGRect(x: 0,
                                 y: 0,
                                 width: self.frame.width,
                                 height: self.frame.height)
        
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
        
        let interval: CGFloat = 5
            layout.sectionInset = UIEdgeInsets.init(top: interval,
                                                    left: interval,
                                                    bottom: 0,
                                                    right: interval)
        
        var view = UICollectionView(frame: secondFrame,
                                    collectionViewLayout: layout)
            view.delegate = self
            view.dataSource = self
        
            view.register(SecondCollectionCell.self,
                      forCellWithReuseIdentifier: ReuseIdentifier.shopCell)

            view.alwaysBounceVertical = true
            view.backgroundColor = .clear
        
        return view
    }()
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.ConfigureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Helper Functions
    private func ConfigureUI() {
        // collectionView
        self.addSubview(self.secondCollection)
    }
    
    
    
    
    // MARK: - API
    
    
}









// MARK: - CollectionView
extension SecondCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.shopCell, for: indexPath) as! SecondCollectionCell

        
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // shop(second) -> detailView로 진입
        self.secondMainDelegate?.secondTapped()
    }
    
    
    // 아이템의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            // 좌우 패딩 30 = 60
            // spacing = 30
            let width = (self.frame.width - 8 - 10 - 1) / 3
            let height = width / 10 * 16
            
            return CGSize(width: width, height: height)
        }
    
    // 상하 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    // 좌우 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
