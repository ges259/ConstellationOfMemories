//
//  FirstCollectionView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/17.
//

import UIKit

final class AchieveFirstView: UIView {
    
    // MARK: - Properties
    // Delegate
    var firstMainDelegate: FirstMainDelegate?
    
    
    
    
    
    
    
    
    // MARK: - Layout
    lazy var firstCollection: UICollectionView = {
        let firstFrame = CGRect(x: 0,
                                y: 0,
                                width: self.frame.width,
                                height: self.frame.height)
        let Layout = UICollectionViewFlowLayout()
            Layout.scrollDirection = .vertical
        
        let interval : CGFloat = 20
            Layout.sectionInset = UIEdgeInsets.init(top: interval / 2,
                                                    left: interval,
                                                    bottom: 0,
                                                    right: interval)
        var view = UICollectionView(frame: firstFrame,
                                    collectionViewLayout: Layout)
        
            view.delegate = self
            view.dataSource = self
        
            view.alwaysBounceVertical = true
            view.backgroundColor = .clear
        
            view.register(AchieveFirstCell.self, forCellWithReuseIdentifier: ReuseIdentifier.firstCollectionCell)
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
        self.addSubview(self.firstCollection)
    }
    
    func upCollectionView() {
        // item이 항상 맨위로 가도록 설정
        let indexPath = IndexPath(item: 0, section: 0)
        self.firstCollection.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    
    
    // MARK: - API
    
    
}











// MARK: - CollectionView
extension AchieveFirstView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    // Cell_For_Row_At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.firstCollectionCell, for: indexPath) as! AchieveFirstCell
        
        return cell
    }
    
    // Did_Select_Row_At
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.firstMainDelegate?.monthDiaryTapped()
    }
    
    // 아이템의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.frame.width - 40 - 4) / 2
        return CGSize(width: width, height: width)
    }

    // 상하 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    // 좌우 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
