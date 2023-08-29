//
//  SecondCollectionView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/17.
//

import UIKit

final class AchieveSecondView: UIView {
    
    // MARK: - Properties
    // Delegate
    var secondMainDelegate: SecondMainDelegate?
    
    
    
    
    
    
    // MARK: - Layout
    lazy var secondCollection: UICollectionView = {
        let secondFrame = CGRect(x: 0,
                                 y: 0,
                                 width: self.frame.width,
                                 height: self.frame.height)
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
        
        let interval: CGFloat = 20
            layout.sectionInset = UIEdgeInsets.init(top: interval / 2,
                                                    left: interval,
                                                    bottom: 0,
                                                    right: interval)
        var view = UICollectionView(frame: secondFrame,
                                    collectionViewLayout: layout)
            view.delegate = self
            view.dataSource = self
        
            view.alwaysBounceVertical = true
            view.backgroundColor = .clear
        
            view.register(AchieveSecondCell.self,
                      forCellWithReuseIdentifier: ReuseIdentifier.secondCollectionCell)
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
    
    func upCollectionView() {
        // item이 항상 맨위로 가도록 설정
        let indexPath = IndexPath(item: 0, section: 0)
        self.secondCollection.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    
    
    
    // MARK: - API
    
    
}









// MARK: - CollectionView

extension AchieveSecondView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Cell
    // 셀의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // 아이템의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 좌우 패딩 30 = 60
        // spacing = 30
        let width = (self.frame.width - 40 - 10) / 2
        let height = width / 10 * 16
        return CGSize(width: width, height: height)
    }
    
    // 상하 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // 좌우 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    
    // MARK: - Cell_For_Row_At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.secondCollectionCell, for: indexPath) as! AchieveSecondCell

        return cell
    }
    
    

    // MARK: - Did_Select_Row_At
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        _ = self.secondCollectionToggle == .achieve
        // achieve_View 일 때
        self.secondMainDelegate?.secondTapped()
        // home_View 일 때
//            : self.headerSegementDelegate?.backgroundColr()
    }
}
