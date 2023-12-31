//
//  ShopCollectionView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/19.
//

import UIKit

final class ShopCollectionView: UIView {
    
    // MARK: - Properties
    // background_Image_Data
    var backgroundData: HaveImg? {
        didSet {
            if let backgroundData = backgroundData {
                self.dontHaveImage = backgroundData.dontHaveDawnImg()
                self.shopCollectionView.reloadData()
            }
        }
    }
    
    private var dontHaveImage = [Int]()
    
    var selectedImg: Int?
    
    // Delegate
    var shopMainDelgate: ShopMainDelegate?
    
    
    
    // MARK: - Layout
    private lazy var shopCollectionView: UICollectionView = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.frame.width,
                           height: self.frame.height)
        
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
        
        let interval: CGFloat = 20
            layout.sectionInset = UIEdgeInsets(top: interval / 2,
                                               left: interval,
                                               bottom: 0,
                                               right: interval)
        
        let view = UICollectionView(frame: frame,
                                    collectionViewLayout: layout)
        
            view.delegate = self
            view.dataSource = self
        
            view.backgroundColor = .clear
        
            view.register(ShopCollectionCell.self,
                          forCellWithReuseIdentifier: ReuseIdentifier.shopCollectionCell)
        return view
    }()
    
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        // addSubView
        self.addSubview(self.shopCollectionView)
        
        // background Color
        self.backgroundColor = .clear
        // alpha
        self.alpha = 0
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    // MARK: - Helper Functions
    private func upCollectionView() {
        // item이 항상 맨위로 가도록 설정
        let indexPath = IndexPath(item: 0, section: 0)
        self.shopCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    
    
    
    
    
    // MARK: - API
    
    
    
    
}





// MARK: - CollectionView
extension ShopCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    // MARK: - Item
    // 셀의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dontHaveImage.count
    }
    // 아이템의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.frame.width - 40 - 10) / 2
        
        return CGSize(width: width, height: width / 10 * 16)
    }
    
    // 상하 space
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    // 좌우 space
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    
    
    // MARK: - Cell_For_Row_At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.shopCollectionCell, for: indexPath) as! ShopCollectionCell
        
        
        cell.haveImage.image = UIImage(named: "\(self.dontHaveImage[indexPath.row])")
        
        
        
        return cell
    }
    
    // MARK: - Did_Select_Row_At
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImg = self.dontHaveImage[indexPath.row]
        self.shopMainDelgate?.shopCellTapped(index: "\(self.dontHaveImage[indexPath.row])")
    }
}
