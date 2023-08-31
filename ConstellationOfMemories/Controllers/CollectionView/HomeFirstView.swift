//
//  HomeFirstCollection.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/29.
//

import UIKit

final class HomeFirstView: UIView {
    
    // MARK: - Properties
    
//    var myFontColor = MyFontColor()
    
    
    var firstHomeDelegate: FirstHomeDelegate?
    
    
    
    
    
    
    
    
    
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
        
            view.register(HomeFirstCell.self, forCellWithReuseIdentifier: ReuseIdentifier.homeFirstCollection)
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
    
    private func upCollectionView() {
        // item이 항상 맨위로 가도록 설정
        self.firstCollection.scrollToItem(at: IndexPath(item: 0, section: 0),
                                          at: .top, animated: true)
    }
}











// MARK: - CollectionView
extension HomeFirstView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fontCount
    }
    
    // Cell_For_Row_At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.homeFirstCollection, for: indexPath) as! HomeFirstCell
        
//            cell.backgroundColor = self.myFontColor.fontColor(index: indexPath.row)
            cell.backgroundColor = fontColor(index: indexPath.row)
        return cell
    }


    // Did_Select_Row_At
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.firstHomeDelegate?.homeFirstTapped(index: indexPath.row)
    }
    
    
    // 아이템의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.frame.width - 40) / 4
        return CGSize(width: width, height: width)
    }

    
    // 상하 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 좌우 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
